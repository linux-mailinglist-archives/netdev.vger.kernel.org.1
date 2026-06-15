Return-Path: <netdev+bounces-299453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gs54KQn5L2rfKgUAu9opvQ
	(envelope-from <netdev+bounces-299453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:07:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584D68687F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=grHea4+O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299453-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0120D304E32F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB53F4109;
	Mon, 15 Jun 2026 13:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC33EEADD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528797; cv=none; b=L/PgCzeNwLzyKY/PfOEg8z10Te5os3jipKYLHsfZiVqqCUEq+c1mEvU2/fmmFmXAa/XFkGiXyfX30vdEllCUboMLqlqpvCHYm3mCl46/GfglL/rXindISuHtn6Q+pj/rAfshj7gmHbyrlp39Daftz9NsdEO3WZpDFFGor9MdL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528797; c=relaxed/simple;
	bh=Iw06VSTSd13id9KhZoBja5SU9senPz0GmL/KsFWNhgg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNgreYwMlqF+f/ZHi1ZbT3t+RCgjr8wDCb49/h8dnPtzdddgNPbuz/g89E/2w9u01rzE0UBhYD9Lz3cqPDMp5WRTM/uLv0Jp/7eBCkC8o1aJCbb2Drr7huYoGel2Q0gRHVi0chKyPiOjm2svS+Nc+MHXDI/Cp7pvTMP5vNY9DUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grHea4+O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE191F0155D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528795;
	bh=Iw06VSTSd13id9KhZoBja5SU9senPz0GmL/KsFWNhgg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=grHea4+O3St7FBU0cs2OI9uzNPZgGZPxcObx9I+gJxmajatBm4NosYYUeDhu3B7mh
	 SThH3AYk1Iq/pLqVzviUgtscm34PjekuBu94uAES8FaHxsrVzgBqLuvEKIeNoF9Kbh
	 otjHGfPuoDhbEY4e9b2+EmZzT/2pmISeY4bN6AENECIMU/RbkHETWgQe7Mt45sa3w5
	 EKOKQb62G5t5fa5MtT0oIRMbeCccKrPyS4qthZ4/emPMKYT1p2Evf8lzfZwh1NnKJq
	 Li/wtDWeDwFddzd9PLU9wMocFWDV5MZm5MHApJWD7EvqwooPMeQaWiGyhLYJhFGM+j
	 7ISY9CaW5ZLug==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39666aac20cso24174931fa.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:06:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yzMAWtxWUi0b1EEICKPDJ99j0y7ioOvD3sHBGMPQOfn/Sdy5UI1fys+UaU6kWvzuiWcWar0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlD4eCpnaKj126zX/tfRL7NX6P4TU4Bd/emgw26kqBRUisniJ
	fp2rNTsWilH8vv8Wg35NpLvfHyVryW2fVk5uIx8uZ+9vKo8CWjq2P19Yg6aWA0J0zqG+Rj0Zi/U
	YtQS1nouifZw/Xav/xD9zxa87CqbeeNFNHLE/s83LEg==
X-Received: by 2002:a05:6512:8016:10b0:5aa:62d3:3833 with SMTP id
 2adb3069b0e04-5ad2db2c528mr2887597e87.5.1781528794189; Mon, 15 Jun 2026
 06:06:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 06:06:32 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 06:06:32 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-0oxBEdfH-fqhdM18pt4JewLwrMOON9qpQgLFh8KS0hDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
 <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
 <CAMRc=McQkLnz2OS2RREAbcrsp47cL-W3bCduq8LwPBBUcVNyJw@mail.gmail.com>
 <CAFEp6-0qsqhcwnSjm3=bG21jsCktzn5-L5sk2pNTZcGuVXaiNA@mail.gmail.com> <CAFEp6-0oxBEdfH-fqhdM18pt4JewLwrMOON9qpQgLFh8KS0hDg@mail.gmail.com>
Date: Mon, 15 Jun 2026 06:06:32 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc6rMwXvo+phxhjioFWwi_kN+yMiEjVwU6Zvu0bgfEaeQ@mail.gmail.com>
X-Gm-Features: AVVi8CcYELXBpxe6-PKRsGQxMXLfew6V8MDcv_4EHem5JqYjvyy5fE7tXsAHiMU
Message-ID: <CAMRc=Mc6rMwXvo+phxhjioFWwi_kN+yMiEjVwU6Zvu0bgfEaeQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] block: implement NVMEM provider
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299453-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:brgl@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0584D68687F

On Mon, 15 Jun 2026 11:33:22 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> On Mon, Jun 15, 2026 at 11:28=E2=80=AFAM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
>>
>
> Also we cannot safely return -EPROBE_DEFER from add_disk_final()
> either. The NVMEM registration point is late in the sequence, too much
> has already happened to easily unwind. The easiest is that the NVMEM
> simply won't be available if registration fails, which looks
> acceptable?
>

I'd argue that it's a problem with subsystem code then as unwinding should
work fine no matter the point in the sequence when it's initiated but I gue=
ss
this isn't really an issue in your patches.

I suppose we shouldn't typically run into probe deferral here so I'm fine j=
ust
ignoring the return value.

Bart

