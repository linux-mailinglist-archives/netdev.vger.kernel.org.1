Return-Path: <netdev+bounces-228998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9CABD6E05
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF6405AC6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822554723;
	Tue, 14 Oct 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpZJnhP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0B28DC4;
	Tue, 14 Oct 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401686; cv=none; b=BxliMGj2Wkcs4xDmzj42MOPkWkYM0qFO2A/yD69Mu3CQTpoAPPoxkrugy6zPO1naXB2GPkOwabLNeBI9hpB5o3pQLep53dt1oGmuh3JSE+T5HOjah5GAWpoav1JJ2TIXvKhEyaPamvZJOERAL9MmVDcLC6coFBomhr7RiwPpK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401686; c=relaxed/simple;
	bh=WMKqBbTTPNId0Z/KIB6ALWHX3PBSDFsvyoDDyEFImb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVp6GVkMvVOVNezvUPkbCAA1e9hrk3NP0eNZVnPIG5J6uJiiJrgoRMlHwwxgzAUyyq+I3sZT7I3NvdjZnE0ctlTU+a3uix/NXzU3twbhpBuqVmYQJMI/ednLHkBcVsy4F4pS+D2ChWYC+c9lfHcFBBd8IPWjeq//cL3ltV4SrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpZJnhP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE37EC4CEE7;
	Tue, 14 Oct 2025 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760401684;
	bh=WMKqBbTTPNId0Z/KIB6ALWHX3PBSDFsvyoDDyEFImb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OpZJnhP0+l0DfyWdFL6jJDHJ8v1sHUzl1NhrDCfbGBgt9CRSOXW2OaKRj3oGt34rZ
	 wtw/d71UnolCb9IvHJzmEblkb/df9WcdJrXwtrZ5pib1lLNkmU0P18BIknpEN1JPm5
	 EeWUJa8WJNaeupoK2PDx9+xQbdi0XwaJ+GW3HTjxN7xk8LdzAgL9Se+tCGbe+y9Nfc
	 Mi6pLwdCejrIzPBnf0lWIvFD9wWtAuvQLBmBFi55qL3xPoNwil2S+addLZTqsNZPjH
	 ZkKVR1WZMkuFS6FQhWdzty6VDysYQ+wbdv+3FMgEpW1ol0rhbshiJqiZdTVD9aFX7K
	 pfomhOenvdkdA==
Date: Mon, 13 Oct 2025 17:28:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Prathosh
 Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: Handle missing or corrupted flash
 configuration
Message-ID: <20251013172802.6cf1901b@kernel.org>
In-Reply-To: <aOzDGT44n_ychCgK@horms.kernel.org>
References: <20251008141445.841113-1-ivecera@redhat.com>
	<aOzDGT44n_ychCgK@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 10:15:05 +0100 Simon Horman wrote:
> I am unsure how much precedence there is for probing a device
> with very limited functionality like this.

Off the top of my head some Intel and Meta drivers do it already, IIRC.

