Return-Path: <netdev+bounces-286986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPscCK/YAmqbyAEAu9opvQ
	(envelope-from <netdev+bounces-286986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878251BF80
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A222301F3CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C43379C28;
	Tue, 12 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AOLMsxdl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42D3672AE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571431; cv=pass; b=FFyVYH+sTYBc8UAq7XrR67aCui/qKFYFsnA70b/UanPz64+kgLUVzvbMETXtnd9YoxfemlIpHUvmcVIbKwDqQf91VR9Z9kupwIcYAtVWtlyl+qE0P5ifTvObAhUFfG+w/OVLshu1P491E4YiRIy9GOWAUfwr+/YHvNo2VCf/FpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571431; c=relaxed/simple;
	bh=bSuyYGGeEmgGvulV57SOqbxrkuecVl057GaOQUAOAak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+4TQoeDSWQ6AUEPt95s5pMGoHyPmVkzGacspQVw2CiXyHBXrQhdi8jIf9B1FRYdj+i/1FboJOzAr2HuO7nu6uofveCiyoh/kejvq4q8Inrg6PMbnbyqrTzaMsNrBzyOsKvCyCJb4hmjjf+v1sO6nEUPZSrBQa/jdOZS7HZVLYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AOLMsxdl; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so39437551fa.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778571427; cv=none;
        d=google.com; s=arc-20240605;
        b=ITVIFvSgSywyYct2DsM8Ldk5hYtAoTGaatNrHmOeZc8VRJLf2VELBh88g2GMqNzG2O
         Pw/1cgT7CRuSpz67iCx3c6HU6N+AXo0q9u0wY/gy34PAKQAFHdVFcRP0iBTJwPtLqAqq
         GpfNtyM4RqJvv7ConkD3l2MHFnZfKH9pxUCgxljmtl1ngES4OFRCKk0Bknn8dpctACQb
         ZlDrG9Vo74IGbbYaWHC+puLQIEQ0r1ek+b0bYOv5oaVqUMf/lLAC7YwlqIR8MwyEh4xD
         7UuBWubxMVfURaQOT0QlgmE2XodvvNoTLe8QTKEVHJL7ZzztqCBsx4KSVGHmP6VqqcWM
         UQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YiGO1DzHy3oKJw39dEBo3ubhTMAjwaktPDTRNxo6tIs=;
        fh=cxWYV/rOTRyLxry9wqtzy2CslieNOiMPY1R9rRCAmyw=;
        b=I6oA96movB3P9JzSE3lEJVLhxioBS8wp2GqaucOFjQA6ZQ9bfwy6WqkSW5htDBYwOQ
         aQhFaJeYeAW9NZ+sNgVZvthIIlkJGhzIguDmah3MoP1Y6c0xP4GCMfKhmYtlQdZVLfsz
         gTLJ0MGL1PVcv3GKGKXUf7NZPZ/94eRMTNwC5Jqz7ifYufYL+H6CwK5hOTkJNmNFNmmd
         RKwN1BjmJyUhpRNQx2sUbDTGk04vTEp9n+axXRP9O0ah3dkPjpX3QYZJ5dQpDhj20Mzr
         GV62kruq9TN9x4yWkUh+/HZDLiIItZSX7NHl/nGQ6FvzjsafRM1pk2VTshEQ2F2jdcyA
         VXhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571427; x=1779176227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiGO1DzHy3oKJw39dEBo3ubhTMAjwaktPDTRNxo6tIs=;
        b=AOLMsxdl95RNOS40d/rtmgSLXWgPQOt8ahxDC98SXp7tJzs3Z0q33cublMzo5/5b0g
         yXX76g9PkD7gsk0pmOY7/nhW1JRZuZujU/Ov5Gg/YUQ3LpWGhv1JSjh7I8cHmfsrBaqN
         MKl30+aVCEVIfykxhfEYhqPRXrdWeMXx6gptCRU6c8Y0pjD3CcQFlwuNyBIbdi30udYR
         c/dKu8U2SLVAG2+TbuV70DpACrlVpAVoj4LU3id0oNhKWQLWIh9E3xjRCeSh+4k0ob+C
         zQalwA9xV3N6u9uRNP1T+SA9b6Sn7pergW3wonQ9up/alUvVjnm/4Tyx2jOFcNgPKyZw
         6w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571427; x=1779176227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YiGO1DzHy3oKJw39dEBo3ubhTMAjwaktPDTRNxo6tIs=;
        b=Vt8c0S6a65gy5XNlsT19/snXK2Satito/MpepJHq0EB2BWqnLyp5zOlgTLdh7yV4t9
         z6GIRGUjfkajgbQ2muXVWdfpOK6RlYR2yMU3iedbp3N3oHR2WQyAFS3UmyDONbX1JUOE
         cnK6iC408hi95QU7/IkoRBtwdfo1ZxQLdNJDnrgYnYxJ22ZtLDeivYU/h7fsngyoP0dt
         nNq126aWwuj/EFcGClmDsUPVvRBO/A0MQ1jge60c8GLyedEqKrGVkruaxG/EmdGhGz2H
         jf7MAZrrNwbH3rOfz1BBcrbxCk9Hnu2LmQvk2aS8kL01WdhkuJSz0SeBY9AQ2tyQDB/0
         LvTA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ao56f36v/ej40X7I1+loJ4NHCNBuUvo55PRUtOErqsmo5K1r7cIKvA+1M/Zs+lFk1xLp4NqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vaiXYCgqxwQQrRTdCMJfSLJJJUdJGuhptyZPpx61U7fjIOqz
	UQuh1iKzapyzjEGVR4rFhGd0auLFd16cY/sXxuWFoO6gvlhU1ZampzNmpMDwU9aSBU0MjHvDxVh
	rh0wAjSo3l5+kQxXoNoHDjZFG6nwB3H2X7gVsK0vxkw==
X-Gm-Gg: Acq92OH0ZP6HCXohJvqVGRV3Lzmni+GXe1z3GsiWWnyBg3czg4aCob0m5VwJFoRwinL
	cewrfZjBipQh9+8vw1xRuCu0OaaQ1NUzpRH9+FKtbpiOqDeos8IXMUmJSItlAiDvfjAm39mpibP
	OBLEKTt/ooDBaaC9X1BeJQO/XlJoNkgcBfWzHuh7DNoPYLEi7/s4vwlmty4qIs/BHkqpV6mpbWG
	amivnb3tvirElQ72XzLT/0ude4dgDmOBpEnxYZ5o17uC/K4KyD0/aj38CR01X9OKX6PSApgSldr
	ZURZT2qgZh9Kb0vXXVDIrRCgB7uNo0WSiF17Apnl
X-Received: by 2002:ac2:4f03:0:b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5a8e31e792cmr603618e87.26.1778571427561; Tue, 12 May 2026
 00:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511134744.277032-1-marco.crivellari@suse.com>
 <20260511134744.277032-3-marco.crivellari@suse.com> <734b9aa0-3af4-819a-49fe-8bba7035856f@ssi.bg>
In-Reply-To: <734b9aa0-3af4-819a-49fe-8bba7035856f@ssi.bg>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 12 May 2026 09:36:56 +0200
X-Gm-Features: AVHnY4Lehk_93YiMVYGd670SPnAUadqGsUhTvlPZSmybCIwdKkGr50QbaYqby5c
Message-ID: <CAAofZF43Yee8ZutA0mR=PnsinkbHwFEafQqtVPvcACpVNhtu=Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] ipvs: Replace use of system_unbound_wq with system_dfl_wq
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0878251BF80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,netfilter.org,strlen.de,nwl.cc];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:dkim,ssi.bg:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:22=E2=80=AFAM Julian Anastasov <ja@ssi.bg> wrote:
> [...]
>         Sorry that such change was delayed but there were
> many changes in IPVS for the last month. The last that may
> delay this patch is:
>
> v3 of "ipvs: avoid possible loop in ip_vs_dst_event on resizing"
> https://lore.kernel.org/lvs-devel/20260510104605.24218-1-ja@ssi.bg/T/#u
>
>         May be we have to wait this change to reach net and
> net-next. Also, we can reconsider which queue to use, these works
> resize hash tables and call synchronize_rcu(), should we switch to
> system_dfl_long_wq if such job is considered "long" ?

Hello Julian,

Thanks for letting me know.

Yes, if it is considered long we can switch to the long unbound version.
I will prepare the v2 with this change.

Thanks!

--

Marco Crivellari

SUSE Labs

