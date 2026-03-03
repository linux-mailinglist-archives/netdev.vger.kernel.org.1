Return-Path: <netdev+bounces-263263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CxIIP34pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:06:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AF1F2041
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 191D83053FD9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB3480327;
	Tue,  3 Mar 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3XT6QNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBB311973
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550001; cv=none; b=DmA4kVTfJf93bVuuBrS+exjMES3SDfb/yzIpV3BtzysP2Z0eWGIcITo9e8IzscQy+wqiSt17SxA296Roo6aoOASZjC3GfiDwcfxKxudtHo4wxVQftQ/gq48ASaMSwjY2ODOUrbVQPWLfJyQwfCb7LkXuUcJF3mVCb8A405cqR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550001; c=relaxed/simple;
	bh=uEQgHtY9MZCTD725CBYZMjAHc2k6m1ThrmWooqXIArA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPIy8d720INkiMHdDFJeYwb6Miz9TbHoSG3gkNNzxNbk30NP7babOAsKsDRYEhBaqFe8u7UefArDgM+m7nG1OLqw7zw9rC9XptnNetxby92ZUZYVWZRQwmBjFzcH1fyuHKLf75Xg42kYL0ntt3zuaG3lWuW9HS4kPrYZY853zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3XT6QNq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so6744345e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772549998; x=1773154798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GiLKMREsyicYQSFfLMBTINVcnbX3xGOhl62R7/wSDcA=;
        b=b3XT6QNq8LwnfX7TcL0c6hhesFGeXATnyylbIayNVpHV9Qpms8ue4x/o0igtFUehNA
         4P6ggKWvEHqcaim0dx8zOJ2sRmM4hWHro6CXii+dRSGecd/xkzYozJ7oStqXkSxq0uS+
         nq+kGPJhnTEOtUXE/YbJP2+6sfxOMRoghnFVOCXDfUJoHJ8reZReUmrnXLiA++APh/+c
         Uyphqv7EmZbiWcGlSxI+R96GCqleGE+HRDS9Vob8Yd+9lxQm8r5cmp6dRl+VxPPYNGhW
         stMsm10Nw3ONdodWsHXwtiutYh8MVOBG3LE14X/xdam9EEzbGuSKFYnriWCsL1sX4dnB
         DhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549998; x=1773154798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiLKMREsyicYQSFfLMBTINVcnbX3xGOhl62R7/wSDcA=;
        b=gGdNjjKkiidMADnlAoH8qeWJr04pOhQs4BgYxYzKAnFzF7crhhunj6mWwbhwrHySNu
         QiCZN+2b4um2CZsIarv/lEl5Bc/NYXOKnze0Yq8L5051+3TTbgBqSG8yKuL5LXtdnRws
         ilVuQw73gTfkqwstpNYSg19UAupDCMOvYMrZf1iy1ingfWJ0bCh4CJgc0G2NfGLizSGp
         Ki1qfScbIftqka9qixILhxDDRLeraNEYgyfVLjpPlywD3i1Y86eYkp8U4q6nNkzTKEUB
         SIHsGMGS9bLNXnBDFY473kQldfzb4eG6bq48hB3fsA2GniMQr/ck6Xc4Dvrbx5Qxe35/
         BCNA==
X-Forwarded-Encrypted: i=1; AJvYcCUyDdEA/9jDk/Kn7uysWvjE7bVlXyZ+yX0rajPz/83HX0gENnNF4PMoA1m2GQjRVUkpfPRBJ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzov40t/0E7A6tRIldmpHc8edfLxn7/S/OJURXUfE4rx1Bv7vvc
	VnNHizRHsBI6gDvChBzrDBvzjvMoTgiHpd8UKMLv56IoeT0SEPEQg1v2
X-Gm-Gg: ATEYQzw62LIs3vw/HB6/UqaCZfbrE5g6oDswpFoto6nnUqut47Gl6g3qDKVLmzjIk1+
	jHL9K7aXd7orc2MeYyKASSX1Wo8zW9JjNmGPu4o883yL5SJVHIh/2qSuGhbMM2WBGm8LcoxjpoX
	AJDdfm7vLFjyFzgsbIFxWn2pTO0GnC9jYh4+RO02frgFpCPFYIAyMMs0ZXal2jbh2Cog8HLzW8d
	9NjXdbaAytl9uOHbOFnbsGZv1HyEMUisynyR47ueRz3aaB3Yevv0TSNoVLyIMaqqwjdu6oixUIN
	XuzKmA/zp1eHXSkFtGdRlXHDo6WZJG4H3DhUFF4jihxrSK1znR4ufZ8XBZwmA1UVMUz26ARO75R
	aDLypFBhOgzHAQk+pUMr5MvxP8xEqSEozTyCpnxNq0spwrPVUc0LZB6U7gqcjsTiwvYD/Yoja7R
	DzFdCa4AouP7bnF/s=
X-Received: by 2002:a05:600c:5249:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-483c9c29b66mr173293595e9.5.1772549998257;
        Tue, 03 Mar 2026 06:59:58 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f2f88sm459994135e9.2.2026.03.03.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:59:57 -0800 (PST)
Date: Tue, 3 Mar 2026 16:59:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/8] net: dsa: lan9645x: add vlan support
Message-ID: <20260303145955.s4kjiwjv6ahn6zph@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 845AF1F2041
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263263-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_vlan_mcast.sh:url,bridge_vlan_aware.sh:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email,bridge_vlan_change_awareness.sh:url,bridge_vlan_unaware.sh:url]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:32PM +0100, Jens Emil Schulz Østergaard wrote:
> Add support for vlanaware bridge. We reserve vid 4095 for standalone
> mode, to implement fdb-isolation. An vlan-unaware bridge uses vid 0.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---

Have you run these from tools/testing/selftests/net/forwarding/? It
would help to know where to look closer for potential problems.

bridge_vlan_aware.sh
bridge_vlan_change_awareness.sh
bridge_vlan_mcast.sh
bridge_vlan_unaware.sh

