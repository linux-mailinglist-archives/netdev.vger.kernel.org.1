Return-Path: <netdev+bounces-272885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHCeOj8YyWkHugUAu9opvQ
	(envelope-from <netdev+bounces-272885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:17:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64958351E72
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B1423012CD6
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E096313552;
	Sun, 29 Mar 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zFjXbUeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27FF9D9
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774786620; cv=pass; b=K51zIJyZL0qszP5SR6r7SW/Q6pzBwRlRS97Xl8f5TB2yfkzeU9YJHNEOOE17xc1qZHtdKL4BCgVCKq3bjFQr3g2bq9gG2Nz5S19X0QAOrjE+6Br0FT5XAvKNhR4lkVfCTDJvocySHJOsmtF+spy3rYQfX8+trgJA47ATmTIguDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774786620; c=relaxed/simple;
	bh=qdUavBcywOTmEA3nUv05/JtHp8D7MHTu6nBaqGdO76M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2iX4u2fxzl03pJzxKpHAvOucmzNXYZrjfpwWHPRW6vFNwKabb7nsHtxITJlxj5z+3+wvdjm1bkZIMwzKzj8xgyp/DqG/iFL8uHmO6jVfOstgxLvznnKRHRS89lTbcLHucVBUlJbYDGyB0hdZG8cYLd6ZNcQ+CTHOdcLYxYnKks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zFjXbUeP; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1340607a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 05:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774786618; cv=none;
        d=google.com; s=arc-20240605;
        b=Xc56/S+qNc1axKKO9TjgYGKD69TDAHbaDSzogixk2QUkFW9LBMRsWpcn+4ZgvITo7y
         1Jd2mc5hn5luBGeRRfRmAAIfC2fbIqISYK68/m9PZQrvmV2k1X1gSWUd8oJ39GuMToaL
         8g5oELjzbmBsNViSDtXFUKDp3I6NiTNTkWpjKtoaDHaAObIJn73OGLhmJNSM1MTDglK8
         5oCDcmYNUoBqSUw1ammqDa24gzC1hH2JZLUB6Teb13WPqElD63VLrDpC041NRn2yxn0U
         2A5dtGbxIGL6ZR/nxrE0nuwSio0Tmh/DpjL3dkpB4QOeIx9hUk0Z6V0BErEhdY5hLDL0
         XQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gg01soe+rLVZmCSMwNZTpDf3gwcvg1nNGP1Rn5/tc5Q=;
        fh=dG4mUNiT5c2hCq5AgiEaiWZC3eg+MyCk7SPsYNpaLaA=;
        b=LDiJ+0WdR+hPao+AhuafcOEPME3Oql+hqwN9BAbu0xXgVrVK/UhxBjcIo8kV+RsqfH
         m+ME6N6jEJ3fzoveh9P4NhWjn7Yf+hipSrW/xzGyhwNE31vxAHw0Wp+O/TaM8HESptWV
         ARyli2b/CCm9U4gNOH334VsE3kX5YW3ywgjGXgwX8mOKVG5OKPy68DbX7clkQM1Xnoum
         Le1OVyGhJp7s4LCEsVX33crERkSLL2aImihPMhmePO8oARkYINwY8XLEVXerpnho4odV
         KdLsID3PyLLJHJ9so+S2OP/JdCgBOR3dduj7sMQ4ODk0Vo7WjBXKZthfIqnYt6bD/zDO
         I8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774786618; x=1775391418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg01soe+rLVZmCSMwNZTpDf3gwcvg1nNGP1Rn5/tc5Q=;
        b=zFjXbUePZkorYCzJBFfI3kUQCMd4r570ccb0aq5MiykxC++j7F0n+sV5sRmIaTTQZg
         zmK5xFrWn+SjwoBP/1vQZHkM+vFGX+eS5yhJIleLixInQ+DpgToJmDwoyTaysWC/bsxX
         zJGO0FxUDCYrOZlWyXZLjCKGkGQ8suX4g+RBEfxmmRbQEvGkK/dL89oAAMJ+u8CD42c6
         wQm5P+1Gq1IidQpD5SbnqXzLeKWUP+lq6LXNRpUvCYk+njqgt3E7fmdvJ03boxNc88MO
         3XD5Ns9NEFOIOg3PfQ1TFcXBiXseGsvAJUq0WMFYrW+suvLDqHMesQH+1IAzdqe6Qb1P
         UHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774786618; x=1775391418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gg01soe+rLVZmCSMwNZTpDf3gwcvg1nNGP1Rn5/tc5Q=;
        b=P6yhTiclXeAIl0DdKBNvt4TimVtGUggNmj8AJyy9TfuBjtjmfWozzUl3rJZaEs+A8a
         SYMd67M/ixA5zgSaXm1A5d4k4AqD0cQ61phiP/I9fTRmvfAP7+ZhpZyxRwKhHy3BnIjS
         j8rLOY/gdB9EN8B94aJhzzyZi1jVWtRaBvi9Tq70sc3QT1d/bVg0dikmYVyAnzwxGdMk
         hH6Sd1DXOH5kO3VfvbdY5UHhbMtFL+JEsZQ6O1NvgR49aQhxdIvHNvZhnH9xpCSPaHMy
         Zycidh/c7pmCxiJLHNuI+dAH7LF4N45ZH2Q4pd8KxEJbboT9py/O9hp42BJBpQFVrKmq
         KeDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWYc/fR0sHOVtMr/SqeSZRde90M2aYhI7RWmT0032qYHVajkKulvhyw1yNAz8Uswq5NxPJ+Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnaTkJhuFr9Qlnzo8myNLa+zjx3MU5ANoIdOA+s3uCIsblSnF
	vbcJH8Uv0YbSt2adaY0n2CdAATw/G7hE9CTaqUy5ps4Ln2s675wBs90DIhmw4sP9Wa/Y97lNSUt
	eaXrWbiqRe9sfbwcVs8nmmt3Kgn4O0aQjBXvLacvL
X-Gm-Gg: ATEYQzy73G6LekwlhGS9gZgd3DzT/nWT5Kubm+qMsqxU8CWVnhr27BrDNigqdA0+gKd
	1PRJiXXYP+uTYN8L+wCAJqo29ChyTAq/uuBVTQlV2XaW6my3378iRKq/tFQyLbzmH1azn8dhNBt
	Azpq3G8dI+lpiV73Mql60spB0XlhvBuGXoj9Bgd2Dq//OtqnV/NQ1Rql/yAMXLUR4N2ayzmi+jP
	9kpIe7hEhxYmUYfcNy8aWtk7jAEURZxQRXRrcBqggS2uXtELb6OU39YXkmFyQR1oGGP6pfCyjU+
	wKb97ZQ/JIdwfSpurmquGyXvzxFt8g==
X-Received: by 2002:a05:6a00:369b:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-82c95d27b82mr8513514b3a.4.1774786618582; Sun, 29 Mar 2026
 05:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328211436.1010152-1-echelonh@gmail.com>
In-Reply-To: <20260328211436.1010152-1-echelonh@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 29 Mar 2026 08:16:47 -0400
X-Gm-Features: AQROBzAvMg8TIlJ0b5duO0OGTLXHBUDApb8R19OmHjfA0Q7YTrgDiwCnkI6m2rM
Message-ID: <CAM0EoMnL-wMSgoV-vc4VEpAOEkk=Hzh5m2j235MYuizdMymKQg@mail.gmail.com>
Subject: Re: [PATCH] net: sched: cls_api: fix tc_chain_fill_node to initialize
 tcm_info to zero to prevent an info-leak
To: Yochai Eisenrich <echelonh@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, security@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272885-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64958351E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 5:14=E2=80=AFPM Yochai Eisenrich <echelonh@gmail.co=
m> wrote:
>
> When building netlink messages, tc_chain_fill_node() never initializes
> the tcm_info field of struct tcmsg. Since the allocation is not zeroed,
> kernel heap memory is leaked to userspace through this 4-byte field.
>
> The fix simply zeroes tcm_info alongside the other fields that are
> already initialized.
>
> Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
> Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/cls_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4829c27446e3..20f7f9ee0b35 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2969,6 +2969,7 @@ static int tc_chain_fill_node(const struct tcf_prot=
o_ops *tmplt_ops,
>         tcm->tcm__pad1 =3D 0;
>         tcm->tcm__pad2 =3D 0;
>         tcm->tcm_handle =3D 0;
> +       tcm->tcm_info =3D 0;
>         if (block->q) {
>                 tcm->tcm_ifindex =3D qdisc_dev(block->q)->ifindex;
>                 tcm->tcm_parent =3D block->q->handle;
> --
> 2.53.0

