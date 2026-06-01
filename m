Return-Path: <netdev+bounces-293883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G1tNevSHWpMfAkAu9opvQ
	(envelope-from <netdev+bounces-293883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D64BE6242F9
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09CAE3017EA2
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE83EB818;
	Mon,  1 Jun 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYA/soCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BF3E3D96
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338156; cv=pass; b=niqBmi2cQUgnW9vmmjlcr23JMZc1pbL+e4kSwyQwlSac00CuRf7MPGb3jsdAZwQbHjhhVp9gQh4g3ZkDbxRastNYSU9aBdIBlahPorZCS0gjKa5rnGmjNGtwtj3Eww+BkvziEoJtDLKuKPUXMMIy+bBJyBrxISVpwOpTBVddwWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338156; c=relaxed/simple;
	bh=N1m33x17+XrHfhbN66kkunHt66Z9GPFsEN5R5dqTEyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc0k1NUxMAFH4wvrqtOi/gZQluRIy1+7+It/GIgV4hslGS64FRVMQywQIiy7/KA+8S9WND9z3xNVP9EFgsPYomzOgLsyBehg3wcI5hM4nPYxaIwE/bavUBHL+UU2ZKMKvja44lwu0nCdKfa78gaD6FjN1yBsz1IRGatqJ6IiLfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYA/soCY; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137bd9ed2b1so2010862c88.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338155; cv=none;
        d=google.com; s=arc-20240605;
        b=fpaFpkf+GDS94DOFC9sGkd2MOrGJqh896AN94RJSGBrUP2KV/i46Itz+NVMjgJqkj3
         OxYbvhzddtCwdbn+k4mk1Elm6xf01C/sQHnbTgdsf+ioi17YzHO26E4rJSYF2M2yP/5F
         qUfV0t3+PvX8n4Z9uSk/zPXmcaO+TSkq738GL8gvjkPSsjQ0fyKiKOmoH5E/fps4Huho
         HmQcj7mQ6jF7lTo9VUEPY4RCyy9iXWlcD9gTJuNHakOB9ndCKl9pB7/OJR5F6VzkCh2Y
         9xGiktSsJADJewLkiqQHY2XioLwzl1Txv4uLIK4KtkMQEzck1gKnr140KIvneb3wg7kT
         TDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9VdHPFcJtMuwlab3hfbQKyW9jn3qtuqt1ofPGzn3rD0=;
        fh=/lelQdmOlpCW9LAk7ZDL5N3lxrSBIcEcPVrlMBwa8Eo=;
        b=B6qBRi52oZfHQIRKIHdONIDTsnouuCJPDaX1tQPPZY3Ix+sDCZdIKtgi6hCcHcjlur
         OTeZed+yi/sJIhu1zOsGSaAakW7HOS32IchtA2HJW1F3ZqydsVbl8V57PD6EgNOpBT+k
         YDTuVCZvz/OduyFCI6h+Cduq4NOAxuqahMb6zcCB7FpPtbke31fUkvl7JydR8LlK29l6
         bUZ9yXcX+0jEcwrSPlHmN3/SoxlwN8FsGbLQ10xA+vKJUNPlH3Xg8B+BKFSpxJEHcNOl
         vgIN8gdjlqV5cvXNbHH+A0KzZKquCjhPBTEYniTkq/a3TEl59xScB/uoVh2Oa6tbrR0D
         VaXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780338155; x=1780942955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VdHPFcJtMuwlab3hfbQKyW9jn3qtuqt1ofPGzn3rD0=;
        b=eYA/soCYFkpf5c4sb6+E/MpEUBL1yD3tZAbhSesBEeC4IhCzswRciYPatVtyOIVlje
         URalwN1azcFQMgPD8MqR5g354aGpRxcWrY4YQt8pFo9/k8GjN0qC/AgK9OaLnNxwUP0u
         21Ei28PMWbFjJ349/4KjkBz/9xIKRyFaMJYeDGnSC/jes9buhq5QOkiSotJ5+HyOYarL
         qhHYfVOTAOFjbTX6OodHp0mNDmULp88ch7Yv6wSpQO/xSfgAmkhjV3v3Gt1ZWuMaItsQ
         yJpU0xsaQ62/ugrXiZhbr2XxERxXa4tIDJtGXPfUPlWBj+t4ynvGaCyzhG9lA77zYYhN
         rzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338155; x=1780942955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9VdHPFcJtMuwlab3hfbQKyW9jn3qtuqt1ofPGzn3rD0=;
        b=F1NTtOsCRFbbmoPflMG8HG4Djvbse091W0sxTtZFHWCfzA8ltlINKekcHaoYv8HhYX
         7dqnSA4giWVzM7YF3xVv2yKNyHMFz23OnTzerQy5uu8gYnBZWu8IeW4oO7WpggW9Giqn
         xemvzFVURpIamn0TbLcZ4tog67rV2+OMAkvBfUAPfsK8/7HCp3xI/E1qQeYR47FRRGGY
         lvTEWzYBDZcmMxnd5IpGBeE2wqzFFeqBrJom+ALmwko/6jEx0MsgoyQPE211uBu0zZQd
         RYKYi7MTZQ6FwgxNcgJt7hD83F2MakOnop4rWMfxQbkhnm/6Dza8vbN3nADRyyRoluXQ
         qUiw==
X-Forwarded-Encrypted: i=1; AFNElJ+bZuC9FpLatUdezvEdffl+PlsQ72VT1pMW1Gjudvi/NfsiA09G2QSdCtVGVZzT/2sDzmCU/pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDYt8S5lk0TkPhmUenJsa8l2GB6a05X48jeNLR/M6F24ry7g2
	yFG53DJYeHtIrt0vwbs+gLczZ53uCOB4wT50fBlQ3zctnaGWZrgrK9o93mQ4Ok9KQJ66BYSQ9gd
	Hjwa6nxSp/hX2xCicf32YoZFBXOxQ+gO8OLT3AF1S
X-Gm-Gg: Acq92OEiQgjLa3GXxB/DWKAunWFW1085lpRVYLqd6DXn5db2ZuA3/ZdjMdnNrYxxEnQ
	VGQVukBE6kWM+16rKb3RKps0v+Zar6eLrZq6vgDzWIe6D31j43S3CyMyjjKKNwcFJqmlYsHeZlk
	F378FTqtnN+KclnIOC+QOTQHBJpbNXt5m3H+uDo7i6JESzoNqvhyEkg1pTQ86nT1JftRgZ+F7Kg
	DrOrdyVt/upNuitqR+JsZIabV9pYQtgG11cSX8wwE1ll/3Yn0TjH0IqwEygKqZBL/9rUT8kNjDb
	wwudAutjIHpSDr1/1pX1hQrj3+YK2wbfLT5Kao+N/MsvNLFA5upVjvM6jvO6NIsHMV0blvd+ObO
	yPrI18jZrwBgwUUYUf1uxpNk8Bd+ssuIKIlPCGrOZGfWHSHlBVaNj2Wi7QLsS
X-Received: by 2002:a05:7022:421:b0:12c:8f92:c6ba with SMTP id
 a92af1059eb24-137d425fce8mr5208824c88.34.1780338153870; Mon, 01 Jun 2026
 11:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601093819.469626-1-edumazet@google.com>
In-Reply-To: <20260601093819.469626-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 1 Jun 2026 11:22:21 -0700
X-Gm-Features: AVHnY4KgJvNNCchzlbhCx5D6zIkR6KMeHh_0DnWmM7j0vtDQI8AjQf0NiBucZXI
Message-ID: <CAAVpQUBL90mSWrNHzSzYf_Vx=wVSw3i3eNZGT7rH7b6ExwCMeA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change bpf_skops_hdr_opt_len() signature
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293883-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D64BE6242F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 2:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Some compilers do not inline bpf_skops_hdr_opt_len() from
> tcp_established_options(), forcing an expensive stack canary
> when CONFIG_STACKPROTECTOR_STRONG=3Dy.
>
> Change bpf_skops_hdr_opt_len() to return @remaining by value
> to remove this stack canary from TCP fast path.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/1 up/down: 10/-59 (-49)
> Function                                     old     new   delta
> bpf_skops_hdr_opt_len                        297     307     +10
> tcp_established_options                      574     515     -59
> Total: Before=3D31456795, After=3D31456746, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

