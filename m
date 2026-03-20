Return-Path: <netdev+bounces-269863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHaMDAATvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F02D7FFE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C80B3067747
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10D3446AD;
	Fri, 20 Mar 2026 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLCL/7fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3E36166E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998743; cv=pass; b=S2dypD7Y4RUeGR8v0yp+z/iKwgLCfPY+7TCnThMNVi391008Xx+H/jDD3iXjYcyUF9h2K8Z9Yti/Th2LpPWphbjGKNam4THY2EC7G8eDPkcCPAHXKqKnBMztiNWRhJ40UOwfByodpxy6YncK2b+0yEDDFPlu7Tm0FleFF4Rsklw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998743; c=relaxed/simple;
	bh=UjWzodMHHiPQ8qpM8gCAfjVpQOUkrpvH4qFscxhdfJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3YdV2C1ikZc7AeVlQpIBnrzaSxNY3/tbu0/tMI1dEMwJhnXY9OcbrZwhskc9Lk2gDtu98k+t7ojpJRQzk6hvD0HuBqgqdBorIMhxRqt1MV+8EQQbpfKX1rdybp18qO0x8HH6AsoB9xLi/73IWt73xTo8SaJXmhz+iRAFHHL2xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLCL/7fw; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fc4425b6bso18208567b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998741; cv=none;
        d=google.com; s=arc-20240605;
        b=lwZg1/o7LG+CzRVlFE5W1aq3TKhAVCqEedzs65+lwEWJmmxzRget9Ej3IRVt4pOR6r
         rYUaNGS0XVtyW8++fKxK/2cDzDE8MLaiw3y23nr7XFkio2ojFr6dpCN78l4hn2qUmTL2
         vnYkDJ6js/Gn0jUZ2px2Ko/8mbiUS9AQ5GShiGznCrsX0fBOyu1sUm+dZ1gJFYHCSe4c
         E3at4bi8H+c3g/l17SgiqceS4plodjXEWrAGsbQzXo1x7kHnqzipoQ4JbQwTON41O1yA
         UsNQ2sVjEEkPoaE9JNAOTg7yHTpUjnUwLHLOnzpu2bBiDe6Q9mFlxEYjtQG3Rq3i3dmz
         DNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjWzodMHHiPQ8qpM8gCAfjVpQOUkrpvH4qFscxhdfJE=;
        fh=vSUZZ3ZYv7MunrSctspCz9emMOvdbfvgHYmBXu3+U/I=;
        b=bvnegwaz7AmQXpyVWxb1X3/CBQm2ruqO50cOdYniFqrugf8+qhysAHSjR8AGj8pVn3
         yoNQvwGZ+un528UJjPaFEwLv+PqZaYiU8gy3R90ZjkOqneMhatdTvR5zxNSuRw4VLLqU
         7zkBcC/Yl31XFrVLyLX7UMP180THzb0k1I1Spj4+GQyTDt/PqIu3vwyUO6o/4EiMUYrF
         47wK3XfZ2bb1tDtLY8XYqcKTbzaf4O3v3Y0xR3BEZwtxvChzOJGlSDDGrwPb0sjDoRW7
         T+Tsv0vdBKTYiCB1RxlTxC+S/h07Gtuy5W/faL7tmeE6Eb5OAcWgaUTTyk0p4sAfiOhl
         s2lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773998741; x=1774603541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjWzodMHHiPQ8qpM8gCAfjVpQOUkrpvH4qFscxhdfJE=;
        b=RLCL/7fwJsh/Jq09SIXC+Hmu4JwrabTPT3SsABrENbCVduGJm/xjoe+iTlX/E0WW3b
         pCxUUWrQ8LT5tSFFXWWJL001ePsp1sLkm4lWCK35HM3Ti17WSdh79IWCYayRpIu0crfb
         TLK0v4OGYBe6lIhnrYhxBCPMbcptXn/eJbk2zgEDNdpMP512pStGoSbBmUUDThPE+nMB
         aEgK9IobmleEOeap3iqWxorJTdB95aXqPu+KDl3xNgjARGqqFwWY+ExeDE7C1tNxV62u
         g45Y3T+EsafPd3t3AOiKrUS4gprwCx18T9kO65gxhXeLJtAObgFvMcaNh5CaJlOF8Ky5
         MKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998741; x=1774603541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjWzodMHHiPQ8qpM8gCAfjVpQOUkrpvH4qFscxhdfJE=;
        b=HTd138AWfrRSoCC8r3aA59d/Fkz1422pJqiscsJKPbpjd1l+xv974bfljNmKrmfSN+
         8h+FYtc7PZZHhBBYE2vb3iXqVacyRvjqP+ruqUg8S+jc8BjBqEC89Yk9WlEBc3avTORX
         m6hka7ZCYRTRZJ4WKPU+P5940BNTcamrA3g1WihiX1Se7P0wEeUH8kVjZ3wl94K0226u
         /2/w5LBsb7u/0LDf4arwfjH7M10zcagakTjD6ZoLsaSFzlCIe2cGZRuUzOTyGAh77qco
         o0neCCNKQXfDt3njxxm1bIoH4mpTLwAEgN6SBp86lKHPONfeJDiE0GEDRONNveKiq2aP
         xQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXodvu6zlaeqtKBWHZDL+1FIOFsRRa+kxy56jEoxS3bsD4tVSFCgRb0B9d7VhaOE/k4Nxqtxn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cDWft2XRw7lCodZFX8vtW05DxMkkg7kXV5glGzU+ATQENF7t
	XoHT7KxMxZr6owetqOcT5Fdc90Fhl0xAnZBSIfeyDYFYV0ZY75GR/1p4x+rttUIqcNbE7+8HH3r
	Etp/UQ8n+xlYr7DrVZshZP3d8VCzsLXk=
X-Gm-Gg: ATEYQzxpLP0LXNRIM+8idDSt9Upkx671UpLsdIttgBYMWbDbU+2dQwMfTVX43nEeF5D
	LMLR28g0oIEdF0IudBewHGWDzQCDWVoMKKuQfgGQlyRXTAxAtDJp7ocN9WMp+oh1ddGdIp4gO7Q
	epCzWFWa/lwFWLPFBgGS11vrf7zKNTf9BwDE+o5QkCVvvJ4VKoJad8svJBNrWsggiU7kbgO10nd
	PdKqErvy7P760+03JsmqskKv9JAg3+d92G8ghyW8/LFhomDyDurDbKe2lCITfJsUEJKj+k/iKMX
	fvpn/ufQYxjGib6y
X-Received: by 2002:a05:690c:3181:b0:798:7498:4ae4 with SMTP id
 00721157ae682-79a90c21cd0mr21006217b3.53.1773998741596; Fri, 20 Mar 2026
 02:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319032649.337812-1-dqfext@gmail.com> <20260320091910.GA2048760@horms.kernel.org>
In-Reply-To: <20260320091910.GA2048760@horms.kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 20 Mar 2026 17:25:29 +0800
X-Gm-Features: AaiRm51UgkKJTce5m7yOHpFLNBuXksPYXf9B03a4b3Hvrvl-JqUwcOrWd9BIh_4
Message-ID: <CALW65jb_4WjSGZyp7ruX1b=DvpkL6HyeNfvAyuBzNYizQaHJdg@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: add RCU lock around dev_fill_forward_path
To: Simon Horman <horms@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269863-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.621];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A14F02D7FFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 5:19=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> I understand from the patch description that the problem didn't manifest
> until this merge commit. But nonetheless I don't think using
> a merge commit in the Fixes tag is the best approach. For one thing,
> it seems somewhat difficult to use effectively to guide backporting.
>
> I would suggest using the flowtable commit as the fixes tag:
>
> Fixes: a8bdd935d1dd ("net: airoha: Add wlan flowtable TX offload")
>
> Or perhaps fixes tags for both a8bdd935d1dd and 0417adf367a0.
>
> Flagged by AI generated code review, which also suggested citing a8bdd935=
d1dd.

Okay, I'll update the tag in v2.

