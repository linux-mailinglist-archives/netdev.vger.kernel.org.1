Return-Path: <netdev+bounces-306851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxkMOTQ6Ump6NQMAu9opvQ
	(envelope-from <netdev+bounces-306851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0747418B4
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=C+8724DD;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306851-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306851-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB873018BDE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC553C5DD4;
	Sat, 11 Jul 2026 12:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879A3C141F
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 12:42:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773732; cv=pass; b=R0hH/kGFa/XyWS80Utbd8y8tLcluicBkAODEP65JA00mObrMN56NZrMokuNHPOMWM3XGQFUOg2gKPlFkoU2+zqEU9tOb4Ilvkhl/BCQQWRh2Ch/Jz9yx0YF5cCWIs3UKuvXmkANrLBpuWe47ktndqqPJ6x0BTDZ4o+Tn/7ewa2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773732; c=relaxed/simple;
	bh=HmgU9O1XNXrsSsBuGbC5dxV9v2oYeREGsOhjaG/ng6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdVp2IjW1N4XJaU+MHZxdf83BnJZPc6tlDvyr1wzGVasUKPnerkjkwS51oNu6dSdPflb99xxf0Q2k+bdA/tYkV+qIOQrJm1pnkNblzCkXz5cBZWyoxbfIQONVqot6oc7sIA/Mu2J8LjH3r4JLmSxq8xTfrRmcIivKJUfKTsoKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+8724DD; arc=pass smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so14645345ad.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783773729; cv=none;
        d=google.com; s=arc-20260327;
        b=cH0CyLcEcMfa1C1VvGEQAu+u8SQPbraDBY9qsUmSbD29DOTi1xC+7f2WHc6qJShFtc
         fw9BL7SjLAUlVebjCrDRplO5TCVjjrqbyKZCIKoorVZd/ykIc+eGapiFXvk+RjhB3PiK
         Uo4DlW4S3vfnju1kjh6EBPcPXAmUl9UQ4z+crpwM4A+9Xjgjx0bJCDszZkyBLagEMgcS
         /ue+LJy1EaruzuyNcrGBo3yWr6ixoyvgIHc+iALeIL8DzYW2bNHe3DNoKOcIzxYYcKhW
         Cu3xJqayWAbbot+hGUUIi52ZmtbHt0HJ1IX7vPz0QXoSWTKlrbl65xU+SpS6vvmlfZh7
         rkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J+zgXlL6HeTawruT8FNlqO+Qy589dfVWy2jR0sGPcWI=;
        fh=+IosjTBEKOyb9fCclIjDYkMMG/QaqSSKotbvVKWH/bs=;
        b=bzkNjhZ6y7pDT32Y9HKUIuquZM2nKPMKYcKN3PH8pIxqW51CnV1rFr+5WuNpPqLadW
         yw+wOM/xqA/oDkul+3VgcDV9BGEdEu6+YkPZ32OJm+/ZI+zHhFgpMNhu9pJQ9olGL8Em
         ymWZhgqE0/Hr3aIkzRAhonxVp74o7lAXpa+Ku03BDCCa/fqk5AU80pVUbOHROlzqpcJM
         Y4lAb1PKWrgU3c98/93Jzr7LEHQystBFnfXgfAn7mB1jXcEJwFF7abgnNYeK7qVkUllB
         2vp4zk+bSWo6W/Ga75YlalcULN6q4T5u6MjZEcebNsHcXbRcEU50mGMgxr0BHAB6tfmN
         TTAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783773729; x=1784378529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+zgXlL6HeTawruT8FNlqO+Qy589dfVWy2jR0sGPcWI=;
        b=C+8724DDZrUSk4pX4tAzjyMtW7cEczKzp2Je/hAfAyutz+ojjQkXQg/yKRfSbp/9ek
         AY0M5yKMTyYmbhHGRE42z5IcSfOgihlAxWIpACz8rwIz1hwaDfS90ap1wY32njOfAk4U
         lI2ClL8mOJwEwp66szeje6tC7NLYSpUGasxtG3jnxpM/1cHx7HCFTus4Lxj+F2fmhRMz
         VsknoMGnKsAJzXy4TnSaihV6W96bPb5A90VZsZZEBQjNB8RPz7mVlJ8f05r0CoQsBSPg
         qV2xYoMDVPT98TJimwBSmH4YG0stFvGV+oDoCWeqRrghX6I9Xl7Bhg9Knev354nGHimJ
         GlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773729; x=1784378529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+zgXlL6HeTawruT8FNlqO+Qy589dfVWy2jR0sGPcWI=;
        b=OzNFBcvtHdRvrhnUv0efVMTuyK/Nyz30tPsefHghFun45p3lRvrNLKW3ShQpDoKZGs
         ITAyDjK9+Ew4vRYIatZ+p90Ba7D+t8xQ3yvOWZuChe9fhovw+/QjzGNEkJNEPe4iViTO
         Jthb+HdhHJOBiw45bhWvBiVnlVHbz8tyK0QYPlPVW07Yf+CWX927O6pUdFchXZ/KFEi4
         6gsJ+h6DibnIwkVNUKBXbcsAVz2rVI4zMRJKleWbssB/pGXPsGQYu2yAWgGeM/MHuwt5
         oNorvWOIPXSL6CPBlLw2V3JR4aUJbOCwHyD58p7Uz/ezruWhgXv7Y+ZyN7CdEywjlqqE
         e0+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpl9NdW7M2OuGaGxbU2b8e2GDgds+X45E/BHx91VP2B/2eBhvMzfn+5mm0FhI5+SHfp9vCI/bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiH2k7KlzwrqTF1F1PshXaEyIsA7vYKNHLCnyLN0uf/r1CK+A
	YVFIg2SYooHQt5DU0+2580U/V9tJCsCqYF/J4n2is5yVhntOMnG8KDJmTHRKD8WxARQoFmZVeM1
	JXO/upjXkohNJEuIwWb38k+2T4QSLeMDEPfiiiszx
X-Gm-Gg: AfdE7cmJcDwTo4KM87basNb8hPh0ElG6N4mQIqD5/G28ASHzhh4Wvg6bz9wD96q7qK7
	7jw8B7SujKZJZ0OWoJr1JPvgAvp0o0jRB/+mImtdcCw/UfLYjNT5CkjEVzCNrrQ1eqrAb9XXLmC
	wStb99v26YbsSk/W1SiSF6LshsJb72Vt5k0YUQ0seLuPdNnoBi5+9Fe6qltfwtY/KfwV6jbW2y7
	QykxnZJKgH8Uk3mgj18n0HzNTWglhBYIiwVmlvTClH7uXf+N1/OeCd3z1MwWMrtesBd4NtIzTPi
	H9PvynEtLAdk38wMeaZPJDypRzmiB1amuBldKZ7SN5Jf4atnBa2MGxpzbH/gdsebqYK2Kl+UiJ0
	xVa2nwQ1nHPErA6sMYznyISzNGcK5vCKqOoEPUAUtOg==
X-Received: by 2002:a05:6a20:6a14:b0:3bf:76d5:4cf2 with SMTP id
 adf61e73a8af0-3c110ad2df3mr2782490637.40.1783773728835; Sat, 11 Jul 2026
 05:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711095147.1972419-1-albin_yang@163.com>
In-Reply-To: <20260711095147.1972419-1-albin_yang@163.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 11 Jul 2026 05:41:57 -0700
X-Gm-Features: AVVi8Ce6Hfh_gWzqmeGtI5FA0UADgED4rxazInXOnYdrY3XOTS6KBIiq0zMxpSQ
Message-ID: <CAAVpQUD4gQNogO1N7iPZB7REQqH7TyU+pfzzUnBTjs4BxqpPyg@mail.gmail.com>
Subject: Re: [PATCH] af_unix: add cond_resched() when flushing receive queue
 on close
To: albin_yang@163.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, albinwyang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306851-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:albin_yang@163.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:albinwyang@tencent.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F0747418B4

On Sat, Jul 11, 2026 at 2:52=E2=80=AFAM <albin_yang@163.com> wrote:
>
> From: Wei Yang <albinwyang@tencent.com>
>
> unix_release_sock() drains sk_receive_queue in a tight loop with no
> rescheduling point.  Each iteration may do extra work depending on
> the socket type: kfree_skb() runs unix_destruct_scm()->fput() for
> SCM_RIGHTS fds on data sockets, and a LISTEN socket recurses into
> unix_release_sock() for each embryonic child.
>
> A long receive queue can hog the CPU and trip the softlockup watchdog
> on CONFIG_PREEMPT_NONE kernels.

AFAIU, CONFIG_PREEMPT_NONE is no longer supported on
modern arch since 7dadeaa6e851, and it also mentions how bad
cond_resched() is.

I think you need to keep this patch downstream.


>  We have reproduced this multiple
> times under stress-ng stress testing.  Add cond_resched() as done in
> similar teardown loops (inet_csk_listen_stop, inet_twsk_purge,
> close_files).
>
> Signed-off-by: Wei Yang <albinwyang@tencent.com>
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..8b4624ce4178 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -724,6 +724,7 @@ static void unix_release_sock(struct sock *sk, int em=
brion)
>
>                 /* passed fds are erased in the kfree_skb hook */
>                 kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +               cond_resched();
>         }
>
>         if (path.dentry)
> --
> 2.43.5
>

