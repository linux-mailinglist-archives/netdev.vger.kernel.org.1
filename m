Return-Path: <netdev+bounces-47102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC047E7C8D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655DCB20D87
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1319BA1;
	Fri, 10 Nov 2023 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rk53w0OZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48179199B4;
	Fri, 10 Nov 2023 13:26:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF527A7529;
	Fri, 10 Nov 2023 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yK5CSSq+F3ZkSEYf7RCLrdlnCJXSx5tx8IAj5BjfQrc=; b=Rk53w0OZUEsoZAUvXWwLGDvIpN
	GVGAnMQD8NYuD/j4I+UWF3yATdhezaD7iQpb5fBuEkXogyxQmGZDe2NCELFHxGkNCDmnZxoM41G+d
	MfMMTKh/tjEhIQeyxBTn6okPObW4h0z6KqCAPcl6hvbtnPJaIE5acqt3aDQ9eZGCBMKU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r1RWT-001ISR-Iv; Fri, 10 Nov 2023 14:26:09 +0100
Date: Fri, 10 Nov 2023 14:26:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <8f476b7c-4647-457b-ab45-d6a979da4e78@lunn.ch>
References: <41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me>
 <20231030.214906.1040067379741914267.fujita.tomonori@gmail.com>
 <1e6bd47b-7252-48f8-a19b-c5a60455bf7b@proton.me>
 <20231108.194647.1383073631008060059.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108.194647.1383073631008060059.fujita.tomonori@gmail.com>

On Wed, Nov 08, 2023 at 07:46:47PM +0900, FUJITA Tomonori wrote:
> On Mon, 30 Oct 2023 16:45:38 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
> 
> >>> But I would wait until we see a response from the bindgen devs on the issue.
> >> 
> >> You meant that they might have a different option on this?
> > 
> > No, before you implement the workaround that Boqun posted you
> > should wait until the bindgen devs say how long/if they will
> > implement it.
> 
> It has been 10 days but no response from bindgen developpers. I guess
> that unlikely bindgen will support the feature until the next merge
> window.

I just took a look around the kernel includes. Here are a few examples
i found, there are many many more.

include/target/iscsi/iscsi_target_core.h:       unsigned int            conn_tx_reset_cpumask:1;
include/media/videobuf2-core.h: unsigned int            synced:1;
include/media/v4l2-ctrls.h:     unsigned int done:1;
include/drm/bridge/samsung-dsim.h:      unsigned int has_freqband:1;
include/net/sock_reuseport.h:   unsigned int            bind_inany:1;
include/net/sock.h:     unsigned char           skc_ipv6only:1;
include/sound/simple_card_utils.h:      unsigned int force_dpcm:1;
include/sound/soc.h:    unsigned int autodisable:1;
include/linux/pci.h:    unsigned int    imm_ready:1;    /* Supports Immediate Readiness */
include/linux/regmap.h: unsigned int use_ack:1;
include/linux/cpuidle.h:        unsigned int            registered:1;
include/linux/regulator/gpio-regulator.h:       unsigned enabled_at_boot:1;
include/linux/phy.h:    unsigned link:1;
include/linux/pm.h:     unsigned int            irq_safe:1;
include/linux/nfs_xdr.h:        unsigned char                   renew:1;
include/linux/iio/iio.h:        unsigned                output:1;
include/linux/drbd.h:           unsigned user_isp:1 ;
include/linux/sched.h:  unsigned                        sched_migrated:1;
include/linux/writeback.h:      unsigned no_cgroup_owner:1;
include/linux/tty_port.h:       unsigned char           console:1;
include/linux/mpi.h:                    unsigned int two_inv_p:1;
include/linux/mmc/host.h:       unsigned int            use_spi_crc:1;
include/linux/netdevice.h:      unsigned                wol_enabled:1;
include/linux/serial_8250.h:    unsigned int            tx_stopped:1;
include/linux/usb.h:    unsigned can_submit:1;
include/linux/firewire.h:       unsigned is_local:1;
include/linux/phylink.h:        unsigned int link:1;
include/linux/gpio_keys.h:      unsigned int rep:1;
include/linux/spi/spi.h:        unsigned        cs_change:1;
include/linux/i2c-mux.h:        unsigned int arbitrator:1;
include/linux/kobject.h:        unsigned int state_in_sysfs:1;
include/linux/kbd_kern.h:       unsigned char ledmode:1;
include/linux/bpf_verifier.h:   unsigned int fit_for_inline:1;
include/linux/rtc.h:    unsigned int uie_irq_active:1;
include/linux/usb/usbnet.h:     unsigned                can_dma_sg:1;
include/linux/usb/serial.h:     unsigned char                   attached:1;
include/linux/usb/gadget.h:     unsigned dir_out:1;
include/linux/comedi/comedidev.h:       unsigned int attached:1;
include/scsi/sg.h:    unsigned int twelve_byte:1;
include/scsi/scsi_host.h:       unsigned emulated:1;
include/scsi/scsi_device.h:     unsigned removable:1;
include/rdma/ib_verbs.h:        unsigned int            ip_gids:1;

And thats just bitfields used as binary values. There are more with
:2, :3, :4, :8, :16.

The point i'm trying to make is that they are used in many
subsystems. Not having bindgen support for them seems like its going
to be a problem.

Isn't this also an unsoundness problem? Is there existing Rust code
which people think is sound but is actually not?

> I prefer adding accessors in the C side rather than the workaround if
> it's fine by Andrew because we have no idea when bindgen will support
> the feature.

Maybe we need a better understanding of the kernel wide implications
of this. It could be this is actually a big issue, and rust-for-linux
can then apply either pressure, or human resources, to get it
implemented.

    Andrew

