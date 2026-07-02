Return-Path: <netdev+bounces-304180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xB9xHTZgRmpYSAsAu9opvQ
	(envelope-from <netdev+bounces-304180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F36F800D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:57:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=OGSf3pvA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304180-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304180-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BACEC302A04B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1B44BCAA;
	Thu,  2 Jul 2026 12:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F72425CC3
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 12:47:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996423; cv=pass; b=ry9/PNzmWepWSPgLZ9IGCZOkma2RLuZ4YxIUnoCRDWKof0VMgNBijBEBdHfKDgHOnzrxhJ1HdirMvWcEiiXgwla83H9qvDYL9V/uw3HlD0X+hi3Ywpqtq3DljIXXiTv9w9bSCYmiJYZrzj4Y2iTi4gqiyRVeaKcW4SA+FhjZCWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996423; c=relaxed/simple;
	bh=oNckSp1C/TB12p42yk8TUfLXS/YDIbgZNDslJOayYZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7Pb8LSJWEJUHDsGytH0xQCbMaaVyo5e9x5p24p0f1RMaPUg/RFDDBlvHce92PGyefYpiKOWU1haA3Zo+9oyb0F2aytGdBAA9P8XkVaqDwta1nfbvZjpEU+1oJqIf53uRCPCFyYOLeyOqkDEqO+3z6Tbrdi0rvgV1xq6bTrfDmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGSf3pvA; arc=pass smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69532288224so3364060a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 05:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782996419; cv=none;
        d=google.com; s=arc-20260327;
        b=T2+CsJMwyygKq+Ij2Io6DNZ566aK5GzOFxAYccBfhxt5dvDGNAkgzOci7RdpRoZzuc
         vNMDOGYub3An9PVcB0VUBIRPlXhrPUxb/7EeVt477mbH1ky6Bxr2unEqEdnLzkYHxB2+
         gazVgkbsaJQoPThqHsThdnLDgfw39wOd0GUr5PIQObWmyRUFWZdPXBZb1HEHyJB5Bp1g
         zl0wd0JO01L+SUKUS2M67/BK9h8/GTp0815LzgT6Tb9UWNWq84L7Ow5y1N70x0+oYo8p
         JGSfi2C5vGwA0NpG3iYMTVHB369m1tWo+Ly6h8MkLRnEgiPmHa8WKDCDmBvQQL+qlNkq
         N1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=210HKleKgbmFKKFSqfRC++HOJhEM15Vlg9VXrqpCJ6A=;
        fh=GwuTX6ZCL2aqGWc8Qe/2tAG20Wahww7n8tBlO/5JDWM=;
        b=nb/QchHVTUQhCeMjQWZTmuIsXJCROZBMpqqxGWWvrDtVS/ehMgP/ZTAn5ykyFTiqM3
         scwng+GYCsDEAL5wFF45GI5wKCFyk+tO5cNb0y3WiJdu/nm54AMywGl7rjKRHVAn4SOr
         utEDT7Q7Ctdg9fZ7OrP2H3Fx4LNnrzTnA4kaoHNQlP4AuWy2wauVhP7myFzk57hpgfeX
         jbIVBzMfhXobJmBm7+8ESLLjTIh69jY2Yyg4/n5NtELIRwoCFnr21pGwwBYOzWIvLqXm
         8CmKhtKfzShidKS+6mXDIjOOPTzR3CPBa+YB0Qq9rbCdQn3Wf5O+zZGiQKb8O/lchLD7
         lVUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782996419; x=1783601219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=210HKleKgbmFKKFSqfRC++HOJhEM15Vlg9VXrqpCJ6A=;
        b=OGSf3pvAfDCo/V8/DLpcvstiZ/O4yTF2dUdmcfLLtHBGexjBgka30990f3A8qcHTxJ
         qoxy4cIqycg2kJAV8SvAEP1n4Pyk9JJ7sLDcPwphZuOSdBuZNjnoAQWOXhFRsMAYbjMk
         Y8klX6PaAhmM5VZp7aLxZwbzHrirR9mnREYXDDZendu7UhN/AC17l2BLFUaJ/rYdZ2gQ
         rEM0bmvBKFlprmi80+nFPEnEiFnPQodDNjX94WJkibPud7mlfruF5INplFaRDOjtwHNa
         Ys1N8sUk9xKMlmUtB06B5i2bGSYUGEhX+i0FF26Nm8Y+pSW/1R30K/Evz/w5bq9h//o5
         LEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996419; x=1783601219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=210HKleKgbmFKKFSqfRC++HOJhEM15Vlg9VXrqpCJ6A=;
        b=oPJJTzkmhSqktD9zhyUD/O+oC0VS+OTbtaR1mlhoJPdIlGyL2cb2o8E5dKLw/DZxDd
         ZYJnC/qxhiUdmqSsPW+psD2NnUDRhISqWbtfiq62Ywl09KXJDZ6CjPtoL1cSQUb7ZMpE
         +ebgxsu1vmP8WLGQHeZ3XpSh+jUeoZbV1VzyPF4HJPKUCvRbQdDQEmfpdyc/mHToV8Uu
         bYjRVKJEgzTkG4nLIHcMMMn6NV2q/R1igEt1ZIb9rRPuDaePPDNnZzimYEk/bRfgZfz7
         a6E/TYdAlfF/mzcOGE9/zIPveeColuiLzJaDZzp58klkoTnH3ZhAKV7o/Lfxj0ldrH7U
         Xvcw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ZOKLE06aN6FM12FIeUQDhiCVdiQLNYig9Jjto9VBCIwPDvW8nlgEGlaCRLesMs0xGLo/WPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvMeHDBXc3CrPkNRA/fg4DoVOgXzuuYbVZN4v709J9QUtdrmN
	c9uNnIt50KE66GIrgPN9ynIwVX3TNa7LDNLuMyqH1FXhMcIvd3vQofiaLhgX4Lf35TkH8YbGI9J
	0IRb9CXj/dMXwgjhE+IEzMkvydULPMTRzWKqC/zU2ag==
X-Gm-Gg: AfdE7cnynAuF2da3rHoIyDtUgAJGXq4JFdLgRaLTsiVjbP+FzW3+byBQKn//YlRrcbA
	WV0l7943oGSWuIKyAYlMedsfS84RtOngK5z2FaVCtlkN0ZxTmznVF8WzHM99CdC7e9Z8P1MwK5u
	4dlb3s3HZZTaUft/QGxAXR+gEFDgMPaGyBR07yYELm8oekbW8OBxLNcM8HI4lPlxgjfRLGUNO5f
	pRYEPCZmHifCUmMyO6DTfPc+po5H2jWysw60TE+yeeM29bRD+UX4+EOJNkepNXSBN3oBtwLeBKm
	cSszFqaNpW2GCqFZAFWBtofTig==
X-Received: by 2002:a17:906:d0da:b0:c12:64c6:bd7 with SMTP id
 a640c23a62f3a-c12a9e053e3mr203835966b.21.1782996418879; Thu, 02 Jul 2026
 05:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203161917.1666696-1-vincent.guittot@linaro.org> <akZcpgDSjAg6gcok@lsv051416.swis.nl-cdc01.nxp.com>
In-Reply-To: <akZcpgDSjAg6gcok@lsv051416.swis.nl-cdc01.nxp.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 2 Jul 2026 14:46:47 +0200
X-Gm-Features: AVVi8CfnsNCvDc67RDsUnObGKCXWxD40T6JSCY5QNMiAlpanyxUGcJsCLPpkpdE
Message-ID: <CAKfTPtDT5NiFcgozfxec0vBi4663fhnNdQGRdGpF6VwpKSJU-g@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] Serdes: s32g: Add support for serdes subsystem
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, linux@armlinux.org.uk, ghennadi.procopciuc@nxp.com, 
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	horms@kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jan.petrous@oss.nxp.com,m:vkoul@kernel.org,m:neil.armstrong@linaro.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ciprianmarian.costea@oss.nxp.com,m:s32@nxp.com,m:p.zabel@pengutronix.de,m:linux@armlinux.org.uk,m:ghennadi.procopciuc@nxp.com,m:Ionut.Vicovan@nxp.com,m:linux-phy@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:Frank.li@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linaro.org:dkim,linaro.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D55F36F800D

On Thu, 2 Jul 2026 at 14:42, Jan Petrous <jan.petrous@oss.nxp.com> wrote:
>
> On Tue, Feb 03, 2026 at 05:19:13PM +0100, Vincent Guittot wrote:
> > s32g SoC family includes 2 serdes subsystems which are made of one PCIe
> > controller, 2 XPCS and a shared Phy. The Phy got 2 lanes that can be
> > configured to output PCIe lanes and/or SGMII.
> >
> > Implement PCIe phy and XPCS support.
> >
> > Change since v1:
> > - Fix compile_test
> > - Use devm_reset_control_get_exclusive()
> > - Fix s32g_serdes_phy_set_mode_ext()
> > - Manage devm_clk_bulk_get_all() returns 0
> > - Fix s32g_serdes_parse_lanes() error management
> > - Move xpcs filein drivers/net/pcs/
> > - Add pcs_inband_caps()
> > - Fix functions in phylink_pcs_ops
> > - Fix MAINTAINERS
> >
> >
> > Vincent Guittot (4):
> >   dt-bindings: serdes: s32g: Add NXP serdes subsystem
> >   phy: s32g: Add serdes subsystem phy
> >   phy: s32g: Add serdes xpcs subsystem
> >   MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver
> >
> >  .../bindings/phy/nxp,s32g-serdes.yaml         |  154 +++
> >  MAINTAINERS                                   |   10 +
> >  drivers/net/pcs/Makefile                      |    1 +
> >  drivers/net/pcs/pcs-nxp-s32g-xpcs.c           | 1006 +++++++++++++++++
> >  drivers/phy/freescale/Kconfig                 |   10 +
> >  drivers/phy/freescale/Makefile                |    1 +
> >  drivers/phy/freescale/phy-nxp-s32g-serdes.c   |  953 ++++++++++++++++
> >  include/linux/pcs/pcs-nxp-s32g-xpcs.h         |   50 +
> >  8 files changed, 2185 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> >  create mode 100644 drivers/net/pcs/pcs-nxp-s32g-xpcs.c
> >  create mode 100644 drivers/phy/freescale/phy-nxp-s32g-serdes.c
> >  create mode 100644 include/linux/pcs/pcs-nxp-s32g-xpcs.h
> >
> > --
> > 2.43.0
> >
>
> Hi Vincent, all,
> I'm taking over the S32G SerDes/XPCS upstreaming. The effort has moved in-house
> at NXP and I'll be carrying it forward, continuing from this v2 rather than
> restarting from zero.
>
> Vincent, thanks for the v1->v2 groundwork. I'll keep your authorship on the
> patches that originate from your series (Co-developed-by plus your
> Signed-off-by) and build on top; I'll send you v3 off-list first, as you
> offered.
>
> A v3 is in preparation and will come as an RFC, with the v2 review comments
> addressed.
>
> Vincent, if you're OK with the handoff, a short ack here would help make the
> transition visible to the reviewers.

Ack

Thanks
Vincent

>
> Thanks.
> /Jan
>

