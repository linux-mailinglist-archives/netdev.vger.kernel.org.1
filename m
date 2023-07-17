Return-Path: <netdev+bounces-18212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF5755D18
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D5C1C20A26
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62C8F7F;
	Mon, 17 Jul 2023 07:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E71FD9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:38:30 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CFE55
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:38:29 -0700 (PDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B1943F731
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689579503;
	bh=MAlGaXtehqgWPJcNsE/u7WTIL9sCas4Vh5dXm4S4XCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nmcoI5g8jSh1RlF1wnhbEYPG8bvA3IprXr101RfoKTIotkiqCUYPyHxo/v2dJpjeM
	 4KvzVVAHd6Wtx6SXuV9r8/mP8aSMaUHoRpK2UHFDljtLy4UHbKEC0px6GnkFKzNzM3
	 Tq4aKYCZOKuScIydbxutmXev+DtDjiMnvIhy0ohcLJIU4nRUFXGHdh2+Sis9CuL7UJ
	 3SdR4JB6laVNPzSU/gaSLGocVabnafa3rSSQ+fFK9G+5YyLAv3020SvqsPvWGVRrFp
	 ceOvNFrkSateI3iYNDvQrMvQMbhSAw9RsOSsbsRj/dird8KY87b7oT5swWkMzYbQgh
	 zwgkLrJ0RLazw==
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765de3a3404so562956685a.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579502; x=1692171502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAlGaXtehqgWPJcNsE/u7WTIL9sCas4Vh5dXm4S4XCE=;
        b=gaL0FCno+iuaO50pd6Q2Og9S8VuR08j4ySQO30zfHawMf75YWsBXv3ATttIf+tA6Bt
         RL3bZe4halc5WT1GkyshbpvHplko3gJjcXjHivIJUk6lFXtAvOgAZ8NEC4LYf0/BdkQJ
         VmXu7sl6yXdX7GrkVDSlnBJRhiIHJhw7PJtoyDaPrNUML2Wl1zRLKYaR8AFtCt+78Zks
         2CiUY4vTB1rjbH4B0CWk5M3jiGR5rTk5+vchaqhMTBMMTs6gfc2CvLV4DeyGkhY6PnVq
         QOrA1MuuDpf0JZyT63koqTC8p1epQBgxlBnyA4U5dGBDhbeXiwebzC1h8Kq+ka50FTPb
         yp5Q==
X-Gm-Message-State: ABy/qLa9rLbih7zIzShLfrkutd7LXdEvIHSfFPC6icgYUP7FeezzkJIy
	0PbLRF6wrYlVfOg0Snz1RylgUUZlVN0mQS3q5ehEbjupRMtYnOELoWRYN1vS+RhTi1jamaC1qvS
	hRaS6p/CBGM13S7/z5Cem6PDb9DhxozmY5RrelK4PCE0xY7O2kQ==
X-Received: by 2002:a05:620a:2403:b0:767:1938:93c7 with SMTP id d3-20020a05620a240300b00767193893c7mr15175713qkn.43.1689579501874;
        Mon, 17 Jul 2023 00:38:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXndrCszhc01Ang+8MTUDFaoQ/GVyMz5a6ACO3CyrHv7+mb6yN+kdZAUzYEE85a5rEttlirRaBhZZJcInJGl0=
X-Received: by 2002:a05:620a:2403:b0:767:1938:93c7 with SMTP id
 d3-20020a05620a240300b00767193893c7mr15175696qkn.43.1689579501610; Mon, 17
 Jul 2023 00:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230714050541.2765246-1-kai.heng.feng@canonical.com> <20230714145445.GA354014@bhelgaas>
In-Reply-To: <20230714145445.GA354014@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 17 Jul 2023 15:38:09 +0800
Message-ID: <CAAd53p4Owt_ygt2f=38M0X2MxnPsXv=BHzSLRbprwW208MUVdQ@mail.gmail.com>
Subject: Re: [PATCH v2] igc: Ignore AER reset when device is suspended
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	linux-pci@vger.kernel.org, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Aaron Ma <aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[+Cc Aaron]

On Fri, Jul 14, 2023 at 10:54=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
> > When a system that connects to a Thunderbolt dock equipped with I225,
> > like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
> > ...
>
> > The issue is that the PTM requests are sending before driver resumes th=
e
> > device. Since the issue can also be observed on Windows, it's quite
> > likely a firmware/hardware limitation.
>
> Does this mean we didn't disable PTM correctly on suspend?  Or is the

PTM gets disabled correctly during suspend, by commit c01163dbd1b8
("PCI/PM: Always disable PTM for all devices during suspend").
Before that commit the suspend will fail.

> device defective and sending PTM requests even though PTM is disabled?

Yes. When S3 resume, I guess the firmware resets the dock and/or I225
so PTM request starts even before the OS is resumed.
AFAIK the issue doesn't happen when s2Idle is used.

>
> If the latter, I vote for a quirk that just disables PTM completely
> for this device.

The S3 resume enables PTM regardless of OS involvement. So I don't
think this will work.

>
> This check in .error_detected() looks out of place to me because
> there's no connection between AER and PTM, there's no connection
> between PTM and the device being enabled, and the connection between
> the device being enabled and being fully resumed is a little tenuous.

True. This patch is just a workaround.

Have you considered my other proposed approach? Like disable AER
completely during suspend, or even defer the resuming of PCIe services
after the entire hierarchy is resumed?

>
> If we must do it this way, maybe add a comment about *why* we're
> checking pci_is_enabled().  Otherwise this will be copied to other
> drivers that don't need it.

Sure.

Kai-Heng

>
> > So avoid resetting the device if it's not resumed. Once the device is
> > fully resumed, the device can work normally.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216850
> > Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > ---
> > v2:
> >  - Fix typo.
> >  - Mention the product name.
> >
> >  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index 9f93f0f4f752..8c36bbe5e428 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -7115,6 +7115,9 @@ static pci_ers_result_t igc_io_error_detected(str=
uct pci_dev *pdev,
> >       struct net_device *netdev =3D pci_get_drvdata(pdev);
> >       struct igc_adapter *adapter =3D netdev_priv(netdev);
> >
> > +     if (!pci_is_enabled(pdev))
> > +             return 0;
> > +
> >       netif_device_detach(netdev);
> >
> >       if (state =3D=3D pci_channel_io_perm_failure)
> > --
> > 2.34.1
> >

