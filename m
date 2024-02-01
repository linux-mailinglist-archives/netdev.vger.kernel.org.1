Return-Path: <netdev+bounces-68120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9B845E11
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEED0B220AD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF55B665;
	Thu,  1 Feb 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V77pz3KO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31635A4F1
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806847; cv=none; b=Hg5giN+DeAVVnO++i6dWEIJ09uiVrxymIbVY14+4b9L/HH2ZpqValiotbpMPJuMWcG4dRsw2kKn+hPzSbrE/GM37PAX01BvpMU68zgVe6YarYhLLg/+fo6rMElRXrPvMnS6WgHqZtYIkvbdLeaAjVL2kXcJ0x1EwIpo8tP8cd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806847; c=relaxed/simple;
	bh=PLSLp9bcVf2PuZymtCHZC6iHxikonaFGkl0Ncm0Ee6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atD6WzJ0brGtVaNkKgesk8bcoNVCPNxKvK89k1b++L1/AhNshBkTwJnEjs1yI1U5Z7A1gFltXEyBDfKPHi/PJ/DYOq86iLjLYeHWGGAcXogEGdHh9LE4R5RRSKOOWiH9tGDBtkGmjbiFkve2QZT5s3w5Pi4cbQB/YqqTYQpPO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V77pz3KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CEFC43390;
	Thu,  1 Feb 2024 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706806847;
	bh=PLSLp9bcVf2PuZymtCHZC6iHxikonaFGkl0Ncm0Ee6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V77pz3KOgsBGt7WynUmINWIFon4yaxXBKJ39dqcHvFtcYWkT7LtBJbI40HhotJgbU
	 2v8/+jiQUFEsOUjgD0JPoR2KVjzeFLI7xouEFYIS/P6FCbQEm0tiDgPaen9iutm5CL
	 /1CDA1xn+UBh72zrM82SeWBfmfjDWgJtdwF7mTu815/EHf4840gVFf21d46ChJoVBi
	 1YaKkyCELxKeOmF+AOHMht3bbWaA2Szxh5pgz5rwXvEnSdD/LLITgmJoCWE55gQbwS
	 c4bWusvlkGYnIe2oD3PXfgNFJmUyZznjR9S89RFB4ydKi0xeoC6NcUbptkap/6ANYL
	 shWMQgAtY7riA==
Date: Thu, 1 Feb 2024 09:00:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net/sched: netem: use extack
Message-ID: <20240201090046.1b93bcbd@kernel.org>
In-Reply-To: <Zbtks__SZIgoDTaj@nanopsycho>
References: <20240201034653.450138-1-stephen@networkplumber.org>
	<20240201034653.450138-2-stephen@networkplumber.org>
	<Zbtks__SZIgoDTaj@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 10:30:27 +0100 Jiri Pirko wrote:
> Thu, Feb 01, 2024 at 04:45:58AM CET, stephen@networkplumber.org wrote:
> >-	if (!opt)
> >+	if (!opt) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Netem missing required parameters");  
> 
> Drop "Netem " here.
> 
> Otherwise, this looks fine.

Looks like most sch's require opt. Would it be a bad idea to pull 
the check out to the caller? Minor simplification, plus the caller
has the outer message so they can use NL_SET_ERR_ATTR_MISS() and
friends.


$ git grep -A1 'if (!opt)' -- net/sched/
net/sched/cls_fw.c:     if (!opt)
net/sched/cls_fw.c-             return handle ? -EINVAL : 0; /* Succeed if it is old method. */
--
net/sched/cls_u32.c:    if (!opt) {
net/sched/cls_u32.c-            if (handle) {
--
net/sched/sch_cbs.c:    if (!opt) {
net/sched/sch_cbs.c-            NL_SET_ERR_MSG(extack, "Missing CBS qdisc options  which are mandatory");
--
net/sched/sch_drr.c:    if (!opt) {
net/sched/sch_drr.c-            NL_SET_ERR_MSG(extack, "DRR options are required for this operation");
--
net/sched/sch_etf.c:    if (!opt) {
net/sched/sch_etf.c-            NL_SET_ERR_MSG(extack,
--
net/sched/sch_ets.c:    if (!opt) {
net/sched/sch_ets.c-            NL_SET_ERR_MSG(extack, "ETS options are required for this operation");
--
net/sched/sch_ets.c:    if (!opt)
net/sched/sch_ets.c-            return -EINVAL;
--
net/sched/sch_gred.c:   if (!opt)
net/sched/sch_gred.c-           return -EINVAL;
--
net/sched/sch_htb.c:    if (!opt)
net/sched/sch_htb.c-            return -EINVAL;
--
net/sched/sch_htb.c:    if (!opt)
net/sched/sch_htb.c-            goto failure;
--
net/sched/sch_multiq.c: if (!opt)
net/sched/sch_multiq.c-         return -EINVAL;
--
net/sched/sch_netem.c:  if (!opt)
net/sched/sch_netem.c-          return -EINVAL;
--
net/sched/sch_prio.c:   if (!opt)
net/sched/sch_prio.c-           return -EINVAL;
--
net/sched/sch_red.c:    if (!opt)
net/sched/sch_red.c-            return -EINVAL;
--
net/sched/sch_skbprio.c:        if (!opt)
net/sched/sch_skbprio.c-                return 0;
--
net/sched/sch_taprio.c: if (!opt)
net/sched/sch_taprio.c-         return -EINVAL;
--
net/sched/sch_tbf.c:    if (!opt)
net/sched/sch_tbf.c-            return -EINVAL;


