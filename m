Return-Path: <netdev+bounces-144136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005499C5B70
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6712831E8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82F200CA8;
	Tue, 12 Nov 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gis4+V27"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36E200C9A;
	Tue, 12 Nov 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423892; cv=none; b=bRsB1xVMEFsAkHaBhvdZybH3MGZ1PbETNWOWrTXZNO2IbSwvW6iKUJ6gtFqqF7+hzMDPbe4As+sStwAVJEWp9dkR67VxKuGrrx3KZ0kMz5OV74BqBgI58ou+wv+kJZxeDMEgnNYXOPm5l1gFkSrJ2LIEnYA6gK1euaIurQVEHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423892; c=relaxed/simple;
	bh=UrBuqAaec/SnMfI6WvyiJtuG1+qWFnWqIsoVsZGcooY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2xQoEsEhHEnyAHglu1GGYV+PokMen7Z40Ba0NDWKLUisWXRmKIxRuufcePF8c+aRHfkJunbG46ez0AqKvY5Iot2IJFrvibbZBluhdgo/dU5/O0DlL6unzrUzMPkJdpwYm9qnq3MrhiCu3F6e9c4quZtHEaafEstV+4K4KiLmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gis4+V27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD9C4CECD;
	Tue, 12 Nov 2024 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423892;
	bh=UrBuqAaec/SnMfI6WvyiJtuG1+qWFnWqIsoVsZGcooY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gis4+V27dEgIGMLFITeRvtwzqx0/dtMnpbKG+qjCb40btNZWCY0HKm1bLUUcGVq4p
	 d05Gbxg8GRSGYM8AyAxJEhMLaqLEIbqaBTYmyE39N0AEM/mQTdEkOlQLFMWNCDYs1X
	 1Ct/SdTyrNWRyasy7/LhYD7OVy9z6818e5fYiiKS029IQMXnj2ed4iAjJgr6XDqgCQ
	 xzwecv0hgJ5eQm3SnWI3n3izI4DiN3LLv3XtLHgNYcST03U21aaOEk3Ts/5bX/97Tz
	 5hZDFDNhaSy8aX+S78kDC+GtxbYuH4OuzQyJadosArHCmVWeMba2cg6iRB+xXhk08v
	 LopIUEA3M4TSw==
Date: Tue, 12 Nov 2024 07:04:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Keller
 <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Wander Lairson Costa" <wander@redhat.com>, <tglx@linutronix.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Simon Horman <horms@kernel.org>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT"
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for
 igb_msix_other"
Message-ID: <20241112070450.5917c986@kernel.org>
In-Reply-To: <2e6cea97-0ebf-4767-b014-680a0502e1f9@intel.com>
References: <20241106111427.7272-1-wander@redhat.com>
	<1b0ecd28-8a59-4f06-b03e-45821143454d@intel.com>
	<20241108122829.Dsax0PwL@linutronix.de>
	<9f3fe7f3-9309-441c-a2c8-4ee8ad51550d@intel.com>
	<20241111125345.T10WlDUG@linutronix.de>
	<2e6cea97-0ebf-4767-b014-680a0502e1f9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 15:52:34 +0100 Przemek Kitszel wrote:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Do you want us to take this directly?
To be clear - we only treat an ack from the maintainer who usually
sends us patches as implicit "please take this directly".

