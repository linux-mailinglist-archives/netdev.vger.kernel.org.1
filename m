Return-Path: <netdev+bounces-39647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A287C0404
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11043281B69
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE330FAC;
	Tue, 10 Oct 2023 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5nCf3jH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339A2FE3C
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813F2C433C7;
	Tue, 10 Oct 2023 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696964491;
	bh=Rj9TPW3i+sJy/5hgvoiNYPM/LPTPX2wzuC1HnJxjCKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5nCf3jHWwnfnUBTjBAqCN/o1vrBjvT8Hv5+ovZCEJMZZnU6FCufqd87Qlsdpv0xA
	 fygN3pz/ZTDOiMRbxa6u6AmvQ6Z7AT7Z13acNc7q2T7/3PZkMZIoEmGpgrdjK1DZhG
	 Ylz5sXK4bNitrHZ8WH4N6LkqX8ZA29mYJqvWsgMUAFyJxKS9DwgfqYE6r9kN9TPrtC
	 P49RipqVPpSJO6xY8y01PrLuKXUzujGv+4V2dguC/q4UJwig22mGx08CxVg6COQUjj
	 GncbfbzNDHw0ZIWTdzgzAfSUQuxSrIV3Z2uC/jrj0PNVm+MMNhSuZY0fDJt9naDFxJ
	 vWWTa8MZ/jqJg==
Date: Tue, 10 Oct 2023 12:01:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231010120130.71918597@kernel.org>
In-Reply-To: <20231010110828.200709-3-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 13:08:21 +0200 Jiri Pirko wrote:
>  tools/net/ynl/lib/ynl.c                     |  6 ++++
>  tools/net/ynl/lib/ynl.h                     |  1 +
>  tools/net/ynl/ynl-gen-c.py                  | 31 +++++++++++++++++++++

"forgotten" to add support to tools/net/ynl/lib/ynl.py ? :]

