Return-Path: <netdev+bounces-237763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4CC5017D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3AD3AD7BB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF42417FB;
	Tue, 11 Nov 2025 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeTxEdme"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0F1C6FEC
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904962; cv=none; b=EwNfHMgvH8k6Z7pPdhAcJfryu0WOL5R0pMnZdXjwAoNlYuOe3k6W8GQai3PU+c0q+J+1a2M06fB64z7UJ49KCtF6DYv1JnPZv44z5u/oMRpHM+Lpr0Y/mXzy9lh1tcsPjuEisvuWlBmaVEG7dND7h4F3wv0q9C/9BMnZT8xpLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904962; c=relaxed/simple;
	bh=ioL/bH+Ccpos/uWWuB/ZdJI6JROjiQmrPoLksQINhnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSd48g/BeVCWmYS0tBypzeVcCMSCo/sqNz/jQ7Kf55AxyR0Db4WyQEGkBdApaLOd/nbcuLfadKLs5MewXkssVgTPs09yiAVu5GlIQLBxjg0cDb92VYXYHOk620xYJRH92qYBCLtjFXRy1tqJGip70mXXNSbHwHFUgWU0NWhL2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeTxEdme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1960C113D0;
	Tue, 11 Nov 2025 23:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762904961;
	bh=ioL/bH+Ccpos/uWWuB/ZdJI6JROjiQmrPoLksQINhnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MeTxEdmeBuOKQQ4Mpv0pqRSZdH40sGXqNr4KL6jwN0rYZ6sidtjyjh0o/6dSIOcg4
	 743/RV5ueUyHltLUlV44O89/J4V1VE1c0npnLrn4iuH3RySe20bpcyZZLYT9k3XYLJ
	 NMZ0HdOq4ynqwaDrfaGzYPs/ZsG3FBrBBqB/jU2wvuG1ko3O23I9ADEsK7H3XOokwf
	 y9HvrHkOxXwwF7Q50dYFryA95dH1fBMwmWhObTQAPISmqPyEKBWaOPq1jr0PIQ3/6M
	 imoLTgEzW1U4DCKa/jFkWBWFXsXpSdDoIWUd5LLkvpnvg474ERq8h7kYsHVgZkQOll
	 aK2M4PAuZ6CMQ==
Date: Tue, 11 Nov 2025 15:49:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zaharido@web.de>
Cc: Zahari Doychev <zahari.doychev@linux.com>, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net,
 matttbe@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH v2 3/3] tools: ynl: ignore index 0 for indexed-arrays
Message-ID: <20251111154920.5803f208@kernel.org>
In-Reply-To: <xk64zrtvsbasla4winq5apbfmfcbbkfeq2td2cpqzlzwurdthx@4o3jwsoztwzt>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
	<20251106151529.453026-4-zahari.doychev@linux.com>
	<20251110172016.3b58437d@kernel.org>
	<xk64zrtvsbasla4winq5apbfmfcbbkfeq2td2cpqzlzwurdthx@4o3jwsoztwzt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 21:34:28 +0200 Zahari Doychev wrote:
> On Mon, Nov 10, 2025 at 05:20:16PM -0800, Jakub Kicinski wrote:
> > On Thu,  6 Nov 2025 16:15:29 +0100 Zahari Doychev wrote:  
> > > Linux tc actions expect the action order to start from index one.
> > > To accommodate this, update the code generation so array indexing
> > > begins at 1 for tc actions.
> > > 
> > > This results in the following change:
> > > 
> > >         array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
> > >         for (i = 0; i < obj->_count.act; i++)
> > > -               tc_act_attrs_put(nlh, i, &obj->act[i]);
> > > +               tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
> > >         ynl_attr_nest_end(nlh, array);
> > > 
> > > This change does not impact other indexed array attributes at
> > > the moment, as analyzed in [1].  
> > 
> > YNL does not aim to provide perfect interfaces with weird old families.
> 
> ok, maybe it is not that bad. I think I can workaround this by creating
> a dummy action at index 0. Does it make sense to send an update of the
> example with such change? 

Yes, the sample itself is nice to have!

