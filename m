Return-Path: <netdev+bounces-267994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLzWAH1at2kTQQEAu9opvQ
	(envelope-from <netdev+bounces-267994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:18:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 594512935D7
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD0C300BC99
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A512516DEB1;
	Mon, 16 Mar 2026 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjiSpsBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A841E531
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773623929; cv=pass; b=YdraINGnVljNDvvbo5/BmYbbdSEraaEawGf6iZQmdIVMGfMVvFhxmRqY9dNEwdRTnSc/Lb7KJcLHum+H0mSIw5jhuNc9HFNkGl3nLBa9KuuUULaOra+CAjlMXet3RGfBaMrbV7Wwzr5tGkBOrQ+Un2GMazSBixspB1X9vx2holc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773623929; c=relaxed/simple;
	bh=cEwqhq3hvm6jf4XtTWtAZxiPYonczF18mUb2nPUk9MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMcPug3gCNzuzeoV6WVo6SPCgQsDz3WOXQnnt8stHIVFdz9uic5VGVqDxQOFD/GnICDyk3Y0OXPNqBPGS3hoTtf55vCV0VYpXfcHPydARG2EjWZjG7cscD4/ZSKiSxNb1LzHZWisGJvcRzL2GlHH5gvYaUVHCfBrg9Xi/xDj2J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjiSpsBU; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be4781d2baso1571565eec.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773623927; cv=none;
        d=google.com; s=arc-20240605;
        b=DNaDz0R09Ue+M7D7MfwpY5jNwLYDhFc46Ti6etMa9cu01a/7zEHemEbvUTeh6Z48oJ
         sGnIl1teLC6KnZrMULtJzhTpKPw0MLVEGxU40ZMiYmP5JlhMsUXiv8xUC3Ciqy8qbshH
         5M36L7PrSBl+DhrlAGGL1UbZG2e0LMSzxmba2fG2T34ynWDppQb46nUY0bqaMiD7sLiq
         Dy/oHFCMiLRjnf83JHXaas3cVcpUAzfWywpzFY/L9C4WhFgxUqQTcnxxT8KDuqmaO3z6
         /FH6ANPUi7CS+P+cyVOQ9npekNENuP+d9S4uCND9C8osz5WIJT4HpJw6DWFhwX3P8EEr
         vf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7uWCj7ghdjAnO5xYtfUB3peGU/wC2KiynUvkIGhrcW0=;
        fh=pIQ9HFN/Bn3TYUbOcbSmZoUO8j1jeUo4qnxcZnFJiV0=;
        b=cz3oTkZYlrLWAtECfzl+smdDlTjl13RgXwCYkU/cAZUs9F+zHr+qDyM0rSKzwVp9Zu
         jI9aSyK80vu/bsXATStT29wpXSeyRC6VndFdMBgxWjLI6pBfnzNuJQnWgY3RzIAV9y2M
         U+9dnT/OacZD1VVWlCIiZq5QzOUaFvMxvtKyiOAu3SW+2Ja63T6fDuL7BDXSDoK4DXKH
         dJWqt5psbqcec9YIm0/tSKOZ83I7PJdFY/5ZV8SpUMkRuzUxxd2j1KQUloEke0F+Ggq7
         RT6MpPQINzErnhCuPRHsVFfJWmFV3g1A7QcU3XXRyyYRJnKahxMxPW2RydM4oxqBvwGe
         Fhfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773623927; x=1774228727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uWCj7ghdjAnO5xYtfUB3peGU/wC2KiynUvkIGhrcW0=;
        b=mjiSpsBUp0rRW0LjP7xgTaEi1xt/b1jWp8ye5+w6NvNQmtB2TNm8uzuCNbb2sEAudp
         4WHkm9BeS4Bi2CAsA8uzFIfQQxZ37lMfWW9vZ0cPiqyWqcQxMomMUV+4M2qbYVoYdL35
         iPI8c4ZZpbQWY0bZJPFNoRpRtrR+qqIChqeyimkuNNo2ZJ7kn5slDSd+MdJBfsX5gE/X
         5M0G7z9G6No4bF5+EDbSA59p5KyB1rR+Ydxqpa0hLkfeER2yOqQrBD3paROfDzb7Fnz3
         3VS17lD/oWO8/3ufVi3aBeQIYS8UIUIK5zr4GAOeloba1RlBXTE/GQOqwBEosYzOLv0d
         c7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773623927; x=1774228727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uWCj7ghdjAnO5xYtfUB3peGU/wC2KiynUvkIGhrcW0=;
        b=qaA8Ja5z3pAULsAGH/8PxKxLn+U5Pl7MkdL3PqQmsA0CK7BIwJpuTNpOlcPD9+21Vk
         aCx3ZQx5yEcolFhfT4MCntuLNG4enxXFyPdKNZkAO0oz1MmJScDWMydPrGpyK/++Y0Tm
         v2+QWh06UGqQ4+0lKc+kix8ftw5l9s/t5QS5IMeqiWdYqKxAvEa+gr77aZMX1eUcVibO
         zWy6ccNLo16krkR5aS6HHOjSoKXkWcXIi+bY6RKqwbN+WKGoQE63c9ut38H+qPTYcy1X
         7vNY+UskdCM2AQaZ0U0h8u2uxzz9GZtAZsSzPDtFdY3HmC9dNeekoi5evppkTGdIh+ki
         GNdg==
X-Forwarded-Encrypted: i=1; AJvYcCUbRBHVBgEdjq4V6pJFlGp2kAsQljZcAEY1+dIBpwZ//bw3LAch4tTzI8UU6BAir5si8GJkv6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyamjDB0S8Zo/qzrWuhtcak2ZoJ13h70EJK6rmy5FfmQNdEuQ
	bnyTy0Dfg8z5wXLsY0oR0PetGJobIvxgemJdH+ceUtxVkeRcPMZI8KMSEMyIA1YdEwPrG9x9+sn
	PfMi2k4+XiISNjnV/pwCgExIMz76tOOvDmikTp+UE
X-Gm-Gg: ATEYQzxGE4dLE9QIc4W+b2Ohw42d5VWMf5ribFRdKWFhHU12BKlrS2ANs3FbaWkG/Mq
	V7IRC1uar7wH4A4/2KCJ0ef5r6JKr8/nndGYaDLrrhEF1EfFyzfTnv6cH8DjkQZOH6S/hDG2kcn
	htsnHXBVAk45LbnP9v6I7ESN8i5rDWyjcjLRaY64PeRhOYt8aceVaXv+VFT74pks2ZEqds3Spas
	bmb+JcZdP0CiMx0YsmeCmNnQIADy5+qI2O/46NHIY2YHkWkHOB3gwiZyZdCKu+mQbP92LbCaW+w
	V5ngbIOEQftBC7/6OQcLM8aLuLjnFQOvoNp3Yz0=
X-Received: by 2002:a05:7022:6284:b0:128:cedb:33c6 with SMTP id
 a92af1059eb24-128f3d6df2amr6359777c88.16.1773623926957; Sun, 15 Mar 2026
 18:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313120346.3378811-1-edumazet@google.com>
In-Reply-To: <20260313120346.3378811-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Mar 2026 18:18:35 -0700
X-Gm-Features: AaiRm51L4OGgjKy9UZ3D4CB-x9Tww8YFyusys008sJNHE8y2PmNICLg3NyPlBes
Message-ID: <CAAVpQUBG=RaeNd1_ZfuTiinM9SuGFvRC9R2hr4zp6P-41S7ZJA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: improve inet6_ehashfn() entropy
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267994-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 594512935D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 5:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Instead of only using the 32 low order bits of the local address,
> use all of them.
>
> Xor net_hash_mix(net) with the 32 high order bits of the local address
> so that we can use __jhash_mix() three times.
>
> If we were hashing 4 extra bytes, we would need one __jhash_final()
> which is a bit expensive.
>
> Using net_hash_mix() at the beginning allows beter register allocation.
>
> We no longer use a cascade of two jhash and inet6_ehash_secret,
> this was dubious/weak.
>
> Add a comment explaining why @lport is not part of the jhash computation.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-24 (-24)
> Function                                     old     new   delta
> inet6_ehashfn                                330     306     -24
> Total: Before=3D24855958, After=3D24855934, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

