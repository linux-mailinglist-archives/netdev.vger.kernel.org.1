Return-Path: <netdev+bounces-302567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vpPVMlFRQmrY4gkAu9opvQ
	(envelope-from <netdev+bounces-302567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A26D92A4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:04:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=vPySupCZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302567-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D653058816
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EDB346AFD;
	Mon, 29 Jun 2026 11:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B675338593
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:00:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730839; cv=pass; b=GEjERpP8mkcza8IpZZ1R95XwTgeNiETqZJ/VjgoNc1QmFmeIOfX+dP5Fj9gCX+qcAoCVgyGsgF8618qF4mv6sOqp2Zvi4219zZfZK+wK1xGj+3ai/d03Rgwxes23f0QcTgvLJo4j0TCgivsIG2cWJKWh02VN+G4z6fPLr11wXEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730839; c=relaxed/simple;
	bh=d9bUFRFkcAVF/hsfuRQFMIWn5yakrRuB3kHsvpivjPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjlLWE/1QBazXFmobuWWMjywBW6h+/6wCwZllN0CkTSo/7Oqr6sV44BuF30Ribd8BQ0OF6zXsFv7EQ8P3PqmSmbG7vWoHpu3Vf6pJubTGHPw+IUbuMTRvbRWe1hU0wb0K3GQZM2ClfMoSmciq4dyUUVP+jREujyMMLjD0i1GFNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPySupCZ; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfbe05683so6009941cf.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 04:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730837; cv=none;
        d=google.com; s=arc-20260327;
        b=FYmVFZX5zB9H38iZRWBM7QqcWWLL7kCAfJA3fhXMDsejj9ye9lNPWdI/hMCMCFIQGN
         B6m+jTCFPFH3CfxPKsqqdodzEz2KiqD6ATcU+a/ZdVybmJkMbVH2GOuf6KA32lOu5kvE
         kqS8cq0biCtiD7bH4SigUVy/mkVtbIo835HtAbA1kJZxCBRFPRr5OK95tyE9JRIusLLE
         Oemv6hi5A8XOfHi1b30aQZt3eKw6KA/8e4UBu9er2AMq+2rI+DPH2v5yofWuOR2a6BYU
         eFfKBxYlPsBZZtOzOuNpqG55d2qg8s16f+HQTAkuw7haYDDIg+BShaxXqBeKignWOWIv
         7t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IuiydVO1YeGeOUVbhoF+gzm0Gc06c1e5LfPUBj8lddM=;
        fh=Jucyx6VDZoP5N33g4MSBnFDoqzGFE3vQZ+SuFxYY3h0=;
        b=pIRw+8KuRIt5NTfLRX+6/xrFAf6ubm7kOsXas+7ACILq2iuwTTcfM+9fHWi+Cg7VXy
         gRNxq2j8HlTyAvm3PD2zm/Ryz0LfSXOYtsxkiDhyiO6kJsUcsbz/IH4B1LjkN34k0uC+
         GTOaFqRGXiXMqXZIuosELP1lBavbtQpxmmOcBB1UB2e7M815419/VimoPZBF78tsuJ4n
         J03L5PDzRSZWhPGlK5Sjp1c0EBJjo6LV+MnwXxL2+AUqSnc85909Mf0XPBhslFFeJR7M
         MPfaUlczTpydvBWt/Tke8kpy2M3qqnDhwJBZ4HRMQmYO9hXYCJP0RJG3cBNlZmjjMqy8
         90nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782730837; x=1783335637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuiydVO1YeGeOUVbhoF+gzm0Gc06c1e5LfPUBj8lddM=;
        b=vPySupCZOrzANtrZKgye2YjMuwKzPskIuCGZn9bZqdgAi8vihKL1TpYbwL29Ep1FAL
         jfNoa4DcPVnkFE4o4IuxEfipUSQ9Xoi66IWjstv11XUyUoo5kVb4Pt4CoyqumcigsPaa
         uDkxAiNX3l+RPD67BoN5a9LUYdTN4zZlciFTssqfkEpdA7pSCxb90eP5J3yaZb7KNhO6
         NLRzW9/w9BT8fLB+29nyl3g082Jyx9B4SChd3MqxF/LXvtHKBcw6EEH3nlK6a0sqw1nE
         6/6WXJ4+yv6g8HCn/zTHcLoK4adVuOPX2piNA/iUDPh0epU3L0j15AuwFvRZvvrED2m+
         caSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730837; x=1783335637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IuiydVO1YeGeOUVbhoF+gzm0Gc06c1e5LfPUBj8lddM=;
        b=kLPtqBXJhB7TLD5jyQT4JgdewYCh9BEjgFZh7/e/HO6q0SSwALLjNi+Fx7k+mLEVG6
         S3GSLmNsDKpyJLChoKJhdcxCHv5a0dTBK7t5jLbCpu4i/DCYnCelzXrpb4m5K+yDpxuJ
         RRELqYpUX+qxFqugPprXsop5mrfSkT3/pp1l2xwCYBBVwNPmQ/TfxnnGYcBAHQ5CYwfE
         b1mxxUY6id9EcArlyFWWFbJ5j/2Rzese9rJCIOqk2POHMwOzZOhi253m72489H4LjYKq
         oBUiwV2Iocpjw2DYi2jY09ShNn9JUBpflAwDCG3sl4lJ2hLMA5ZPaZIA33TDxIiYtJJa
         NJLw==
X-Gm-Message-State: AOJu0YwBimbe6w8HQ98t8K9yuO9sxb3vfm/8uRoTy0lu1ZORh6ys1HjM
	ll2l/JdrRcrY7ZqVi+3Yw8IxFv51jim9qGQu+wB4nZ0qjUgcI2puS6T+24fMld8151jun+ydgB/
	U552rlkVXWiGkHRVU+UylfqjpxxASodGOFXfiJzmb
X-Gm-Gg: AfdE7clxVNRrjezJOo7Ix6czfK4Z1maLf8H6wI4NdbgdTznIBW6AEc4yqs9x7+DsziN
	EDAJgQGn+1szh+ypO8olvlnDBSmftKtUo0P+GRIQTNdqBCH4fnxopqjhLGo+wtsG0k8yRR0iHm/
	8jNVGOLAYaXORE3BPGgSIky4A0ELehiicGLU6cb5IEKDW49T+sLX99rwtjd0K60p0f0cAcF0zhI
	UkqAzfOraSrUIEUmv8N4FUBjhWl7HTb6NwBhF6/glF5nDvNxb1U06DEPguA3UGX2/88zvgg8uVI
	ufvj7Rcjk+ev+3YJrw4AOCGv/59d2IfR9NS0Owt37QQqxfRwfXeVvr8sxnqBCWp0vWX2mOhu33x
	+wV16+DA=
X-Received: by 2002:ac8:5558:0:b0:51c:63b:3b70 with SMTP id
 d75a77b69052e-51c063b3ce6mr11447221cf.17.1782730836248; Mon, 29 Jun 2026
 04:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782643946.git.roxy520tt@gmail.com> <02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com>
In-Reply-To: <02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jun 2026 04:00:24 -0700
X-Gm-Features: AVVi8CdVVFVcuH-41Bt5pOxvcv1rd-qM0ogvYjmsqGnxu8WZoc6RDrE2qVIbaFY
Message-ID: <CANn89i+zu=9LAaSppJ_+YZQK8Mu5HVmoQa9uw17MDY+cXdpXkw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, 
	bronzed_45_vested@icloud.com, yuuchihsu@gmail.com, idosch@nvidia.com, 
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, roxy520tt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,icloud.com,gmail.com,nvidia.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 224A26D92A4

On Sun, Jun 28, 2026 at 4:43=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>

...

> -       max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
> -               READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) +=
 1;
> +       max_retries =3D READ_ONCE(icsk->icsk_syn_retries);
> +       if (!max_retries) {
> +               max_retries =3D READ_ONCE(net->ipv4.sysctl_tcp_synack_ret=
ries);
> +               max_retries++;
> +       }

Please do not change this part which looks good, let's avoid code churn.

