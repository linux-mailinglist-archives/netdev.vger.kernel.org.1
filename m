Return-Path: <netdev+bounces-14189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D721173F691
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1E280C7B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92715496;
	Tue, 27 Jun 2023 08:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6041373
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:13:33 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63533C7
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:13:30 -0700 (PDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F9D53F22B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687853608;
	bh=gg3OEKCdXYQ44h8MuGgBj8DaSBevkCPyPNd3zprHKaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ruCPA+rno4IxSxEK4THvNIJYKsO7O/fRL+Drzn/I3PzKik+cY0w5Ckk9e8lvyvMfl
	 9GEZO8zvd1NIR/0oEeD0ym1G4VwDI+p6/M/S/qCe53x/Fm9wWExkeBtipnympOCjKu
	 NCtcHPvSCzYZA67pxoSegcN1QFsG3omeRaaYu5tH1RQ4fIocAdL9latzwM0mfI5Q/T
	 +Rdg4P9Qm85tpx8xG5c98zaFKzdPPByoJQTIZPJzmk6eXxOkUZ0z9cbl8ut6AvpnAE
	 A7DQnPcoV7jtA2G0t3Sr7GlFurZvwHEWiF7qmCq2pYuxn7X0W6xsQpAA83OzpA7N+X
	 3lwDyJk3Yj0fA==
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33d5df1a8ddso24305735ab.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853606; x=1690445606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg3OEKCdXYQ44h8MuGgBj8DaSBevkCPyPNd3zprHKaY=;
        b=Cj6ouO48dmjOvyKY4x07lGgu++RAyWsAYo3KnI+xAupEHIGsBXU1cD72k4yItSuqxS
         YKcIBHQddWI0DsFFhJbIwdGbMFXyPIXHLBhowkWCTxbE0uX2xR++5vC5JpXAsdaVCMGy
         BrSqUZ6kskzCdLV1zTNXrWgZ3G+iG9mn3TD3+BzISEk6oMuIXl82MfcIkQRMgA32SVQK
         pe3ziVSfgRVQ4fU7ubYvC5+qd0mkYiaYC7eB2yjA000iVPxwssptRmIdxaGI5ellY24Q
         9jS91Ev5Ne7mwBGXKzBxh98bjwTdEA7s/7poDtHb21ZKYoMX8s7XSTyrina/hSgZfa2x
         bs4g==
X-Gm-Message-State: AC+VfDxtujivGGKYuOiAZ21oVZOqa6U8Mbio0gWOqdHFksTcsI6nHkaA
	UubxeV/NIftfBE+qUavlwzEB3pizNoSsaQgbYqxXu5SMk+PD6YZESyt7Zk3K0iViwu3hlYqYGlG
	vHQ7rgW/64DEdZIcv5YjWnRg01PE2j2cXZl81zk7728+hVf0e/Q==
X-Received: by 2002:a05:620a:b5d:b0:765:a99c:96f3 with SMTP id x29-20020a05620a0b5d00b00765a99c96f3mr3991344qkg.28.1687853585410;
        Tue, 27 Jun 2023 01:13:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fgqyY3eOukJw2FU7SKafinmfoAL+d8SvblNvlFQgx5Qor6fZJCGh2ay3cp5ysEdiBq4nqsWO1NHqtqMWrOIU=
X-Received: by 2002:a05:620a:b5d:b0:765:a99c:96f3 with SMTP id
 x29-20020a05620a0b5d00b00765a99c96f3mr3991319qkg.28.1687853585132; Tue, 27
 Jun 2023 01:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <16bcc313-a4e1-ab50-4487-c99ccf5ecdf9@intel.com> <20230622131123.GA137990@bhelgaas>
In-Reply-To: <20230622131123.GA137990@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 27 Jun 2023 16:12:53 +0800
Message-ID: <CAAd53p7EXmqe2CMnrVGK_DUcQZVxCPwcFdVFkPPSUZaPDjwz0g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] igc: Ignore AER reset when device is suspended
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, 
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, 
	"Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org, 
	"Mushayev, Nikolay" <nikolay.mushayev@intel.com>, linux-kernel@vger.kernel.org, 
	jesse.brandeburg@intel.com, "Edri, Michael" <michael.edri@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Eric Dumazet <edumazet@google.com>, anthony.l.nguyen@intel.com, 
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>, 
	"Avivi, Amir" <amir.avivi@intel.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 9:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Jun 22, 2023 at 08:09:34AM +0300, Neftin, Sasha wrote:
> > On 6/21/2023 23:43, Bjorn Helgaas wrote:
> > > On Tue, Jun 20, 2023 at 08:36:36PM +0800, Kai-Heng Feng wrote:
> > > > When a system that connects to a Thunderbolt dock equipped with I22=
5,
> > > > I225 stops working after S3 resume:
>
> > > > The issue is that the PTM requests are sending before driver resume=
s the
> > > > device. Since the issue can also be observed on Windows, it's quite
> > > > likely a firmware/hardwar limitation.
> > >
> > > I thought c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices
> > > during suspend") would turn off PTM.  Is that not working for this
> > > path, or are we re-enabling PTM incorrectly, or something else?
> >
> > I think we hit on the HW bug here. On some i225/6 parts, PTM requests a=
re
> > sent before SW takes ownership of the device. This patch could help.
>
> Is there an erratum we can read?  If this is needed to work around a
> hardware defect, there should be a comment in the code to that effect,
> and we should have a better understanding because there may be other
> scenarios (suspend/resume, hotplug, etc) that need similar changes.

Actually, similar message can be seen on hotplugging the device. The
AER message will be gone shortly after the driver done it's probing.

>
> (I know this patch is to work around a suspend/resume issue, but the
> change is in the AER error recovery path, so it doesn't quite fit
> together for me yet.)

This is something I really want to discuss.
This is not the first time that AER handling doesn't play well with
system resume because the error handling and resume routine can happen
at the same time. Some possible way going forward:
1) Serialize error recovery and resume routine.
  - If error recovery happens first and it's a successful recovery,
does the resume callback still need to be called?
  - If the device successfully resume, is the error recovery routine
still needed?
 So I think the most plausible way is to call error recovery only if
the resume fails. Ignore the AER if resume success.

2) Disable the AER interrupt during suspend
 - Since the AER is still recorded and AER interrupt gets enabled by
port driver before child device resuming, the error recovery/resume
race can still happen.
 - So the port services resume routines can only be called after the
entire PCIe hierarchy is resumed.

3) Disable the AER service completely during suspend
 - This is what's in my mind. If the AER is caused by firmware and
hardware (like most cases), the most feasible way is to workaround the
issue in the driver.

IMO ether 1) or 2) requires involvements that add little benefit. So
hopefully we can opt to 3).

>
> Are you saying the NIC sends PTM requests when it doesn't have PTM
> Enable set?

I think I mentioned during previous discussion. The PTM gets enabled
by the firmware/hardware on the TBT dock right on S3 resume.
The issue is also logged on Windows' Event Viewer, but hardware vendor
doesn't care at all since the device is still functional :)

>
> What exactly does it mean for "SW to take ownership of the device"?
> What PCIe transaction would tell the device the SW has taken
> ownership?

Please correct me if I am wrong, but Intel ethernet devices may need
the driver to perform some actions so the ownership can be switched
between software and firmware.

Kai-Heng

>
> So far this feels kind of hand-wavey.
>
> > > Checking pci_is_enable() in the .error_detected() callback looks like
> > > a pattern that may need to be replicated in many other drivers, which
> > > makes me think it may not be the best approach.
> > >
> > > > So avoid resetting the device if it's not resumed. Once the device =
is
> > > > fully resumed, the device can work normally.
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216850
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/ne=
t/ethernet/intel/igc/igc_main.c
> > > > index fa764190f270..6a46f886ff43 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -6962,6 +6962,9 @@ static pci_ers_result_t igc_io_error_detected=
(struct pci_dev *pdev,
> > > >           struct net_device *netdev =3D pci_get_drvdata(pdev);
> > > >           struct igc_adapter *adapter =3D netdev_priv(netdev);
> > > > + if (!pci_is_enabled(pdev))
> > > > +         return 0;
> > > > +
> > > >           netif_device_detach(netdev);
> > > >           if (state =3D=3D pci_channel_io_perm_failure)

