Return-Path: <netdev+bounces-223095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB217B57F50
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E771A271FD
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190E313276;
	Mon, 15 Sep 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LqJ1pXqq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7C1C3C11
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947323; cv=none; b=P1xO7tLCHn/+rSlHcXA1JkwjcffZs59iOBjPhEygptbHQi9khTyJVFkiL1IhGVWD9wPjSIAvl2XpbgQFra/ym+NuN4kwoy5gOvc5hHad0CQrfkulWyqL+neI465X6v4lcxkNSPSSQ4Jq+K4Crq3H6uBr3twSdHMAsDmv/cEc++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947323; c=relaxed/simple;
	bh=NWQA9Sn7X7dL4WNBejase3U5J4N4BkaATHQKiROmKEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFNntgqvvrNPEYC7r8HJ23PTOiJp6djjtsVfYKFbsp/Ruz8YGzOuekcsC8BZ3BoyhNsAFE7vO8c1hKJh/npLymslGmt8i/yXEOSRcq8aDcsIDbFBS0UnEICyC02Zjycmi6mpcmJbJPe8axx00pSuz6Cay8/27qKPM3jrjEWouQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LqJ1pXqq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=30JGm1SFpFWomyuboYJMW7aCvTG6NV4SnHphw5lTAMA=; b=LqJ1pXqqHAWnh902yoqkGBkDMb
	MhNw1RLPZ/Ix4VtR8d0JIowY/XaPnA75b5RHjNoCEo98d0LYA1tMMPBvaTVF141ZHKz62R7EIAlbH
	UQvwcoan8OifyHsIw3GPFWIXqzaKH7so5KhSanF9gRdUn+akmryKL7dxTos4fd/yGUztb7osItfwb
	7D8z/PQmkuGgXJazqxOBnc61RSm7EkD8Van5zX3hVXVPfkZYRq1m1z0XzeJo82v94qznByg4ij+6p
	E0Y8mFC7K98h/OcJFr9wSGmHxQ3ea3uLzYNwN4IDqIb91WMvA6j7isXdxMLa5w0K3F3lcZ2yETz8Q
	lACIFQzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyAOq-000000000f8-1KQT;
	Mon, 15 Sep 2025 15:41:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyAOl-000000006kU-2SAB;
	Mon, 15 Sep 2025 15:41:43 +0100
Date: Mon, 15 Sep 2025 15:41:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net-next 0/2] ptp: safely cleanup when unregistering a PTP
 clock
Message-ID: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

(I'm assuming drivers/ptp/ patches go via net-next as there is no
git tree against the "PTP HARDWARE CLOCK SUPPORT" maintainers entry.)

The standard rule in the kernel for unregistering user visible devices
is to unpublish the userspace API before doing any shutdown of the
resources necessary for the operation of the device.

PTP has several issues in this area:

1. ptp_clock_unregister() cancells and destroys work while the PTP
   chardev is still published, which gives the opportunity for a
   precisely timed user API call to cause a driver to attempt to
   queue the aux work.

2. PTP pins are not cleaned up - if userspace has enabled PTP pins,
   e.g. for extts, drivers are forced to do cleanup before calling
   ptp_clock_unregister() to stop events being forwarded into the
   PTP layer. E.g mv88e6xxx cancells its internal tai_event_work
   to avoid calling into the PTP clock code with a stale ptp_clock
   pointer, but a badly timed userspace EXTTS enable will re-schedule
   the tai_event_work.

Simplify the process by ensuring that:

1. we take a referene on the PTP struct device to stop the
   ptp_clock structure going away underneath us when we call
   posix_clock_unregister().

2. call posix_clock_unregister() to remove the /dev/ptp* device.

3. add additional functionality to disable any PTP pins that have
   been configured on this device. This should shutdown all events
   coming from PTP clock drivers.

4. cancel the delayed aux_work and destroy the kthread.

5. remove the PPS source.

6. drop the reference on the PTP struct device to allow the
   ptp_clock structure to be released.

This is difficult for me to test beyond build testing - on the
Clearfog platform with Marvell PHY PTP, the ethernet PHY is the
primary connectivity, so removing the PHY driver for an in-use
network interface isn't possible.

On the ZII rev B platform, where the DSA switches have the TAI
hardware and where root NFS is used, removal of the DSA switch
module somehow forces the FEC interface _not_ connected to the DSA
switch to lose link, causing the machine to become unresponsive
as its root filesystem vanishes.

 drivers/ptp/ptp_chardev.c | 21 ++++++++++++++++++++-
 drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
 drivers/ptp/ptp_private.h |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

