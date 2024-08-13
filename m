Return-Path: <netdev+bounces-117970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22D9501E1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326361C21EE0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FED189BB5;
	Tue, 13 Aug 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="czzEor0u"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4419470
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543352; cv=none; b=SC6LeQCEQCEGRAV81zakJegnmY3ocZTPYIoEJ4r9Wc20p+WE3Mpud/ZB1CJcw7f6etLS9RTmocZ4qT6w+b3a7Po0mVEmJNY7epgMM17+ZGLiYsVLCoqWlZ27DA2KfBVdMpusAN1vAuFLFFWXYcbna78sjqncBKx77XRsgR6GPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543352; c=relaxed/simple;
	bh=yCuEHSruau3ols3pRDwQdUM75FmNDJH2gWAfUQrOLLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Eho86f508Z+qhShjLhWzYAfYk14BVfQaXuTdlmMz6lqh2QXoVtHTbefrt/P/Jw4N888objB6KAyrm0eUD0ymJxxccY9dhO9hQmrbFBToGqM1WqzSZ1ZsnDJUvD30D6FnX9GONIbPmPPeBLowb7+KYekYdXKmTpcQGt2zYLPVARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=czzEor0u; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723543335; x=1724148135;
	i=foss@martin-whitaker.me.uk;
	bh=HDtT6KbLJOYvicw8BUtswCd2mwUqzyI5HQdSEBZSfJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=czzEor0uG8iFI/Swx8IURE637csU5NncyoQZ7OP0Clhz7ipytu5nAp5JTVIESVmc
	 z9fO7qc8LjkbXxBV9eFR/Mh6t0kKBqh8OdherOkl+B6/+nGI7oIh6/lKx3hllmeio
	 VkW6ocKKMSXf3YhWDtTSpB515HVPQgDLo95qFOhKG52h1uBx6AxIqKt1Xh6WOYx/Z
	 Qwhj2bhdfEZ7g5GiBtlC0ufwwnERCkibhJwWI59+Qun0oyx5yr5ee3uFlmxf74Rpj
	 OKAxt0LV72LNo3RFOfxCOwpr1sPW/0HIp39A2mSzsoWqKkVaHqYpKn91QyHlDgabf
	 YWuBiu6n5Y784oF2rg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.14] ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1MxHLs-1sFpQU3cgi-00r9CS; Tue, 13 Aug 2024 12:02:14 +0200
Message-ID: <7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk>
Date: Tue, 13 Aug 2024 11:04:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Whitaker <foss@martin-whitaker.me.uk>
Subject: net: dsa: microchip: issues when using PTP between KSZ9567 devices
To: netdev@vger.kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, ceggers@arri.de,
 arun.ramadoss@microchip.com
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M3isctBkdpr9Y3h4Kzttulp8BA5XsSFuyRr7PkJs3LEsfiHcHe+
 ezfqVuccO7ARZtyTAthIsac2OupQjqhA/XeQvYojDRvhGw70+wPbS8eF5Nuw2O3pslqGXnY
 XvyTI2m1m6MI/7ueUbSmhKeofdxfT63oPyOwdObiVa+hhwZh5dZ5MlqjT6MYz8+dILKNbEJ
 QUe04VyRTvdNMKSQ/cqFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DOp64zMO6Pw=;MKaBScPWrvcvdxPf01SqLOyiwcE
 FPhpm9eTHXlfPMIkvsx6aqafabRIUA+rfLtefab9jDk35NLOz1AjN0a5vQy2QcE27tsAZUvJu
 YyzcEbhDVn0v5bPxzL0IDRoa2KBK1QGtlGiAIWl4M0xUqN0INtEVaVNid14HbUlPqkGZoWwL+
 Q2hfQXSfnJBXip9VFw0Jnu7tqUPdAQcx7D4kv9TylmLDJy2YufsBollkBetAtJPW/GOgoItf3
 rtOYEpkXLiYWGyaXaEQ+OOnZVn8KeHJOpayp10E937Zeu9Vau9QovrdAdzT+CAdCP6cgmEUzn
 WM6TaYhM8r38JewlR2jN1DQEKhVDK6eODh5KslaEd57xKDJd94MPbE/RBiFpKAhv7SfHlj++t
 wHTC/B88RPbOrsQeQ72tWGDnPq7QqRHdkJgXpVgpNaYjjbdc+ISOi7HAeADHkE+y83empvpRH
 xEyWkA3g9/ACu9awGET8Ezzhjou0IW5FeZCR9RxRjxUED0SOUVhwtHKKQwUBZYZw8ry0aRIle
 zgqHyZ31ShuYlJ1gMDxo2gVDLQfdiaEaYzHxZWUzvJ0HtZvuLEd2HSF1X+JkBHDmy0EKO+Gcq
 KzP2hkHzJ3+glWuFgDWNb/64EL00RIMcBw03SCdB3xCCRwF1adpSP8FktwXbnjmCgi9CWqHT5
 0GoW2AYzTicu1nwxoQsOZ7v4zYvEcSlZOkcu+dxbL4dzHvSFEMV97Ty6H3rvJavXUoXY9JjCc
 gT3h5Cn/HX0geKr1z0bdSkhN4kypYvL9w==

Three issues. The first two look like hardware bugs. The third is a
driver bug.

I have an embedded processor board running Linux that incorporates a
KSZ9567 ethernet switch. The first port of the switch is used as a WAN
port. The second and third ports are used as two LAN ports. The aim is
to daisy-chain multiple boards via the LAN ports and synchronise their
clocks using PTP, with one board acting as the PTP grand master.
Currently I am testing this with only two boards and one active LAN
connection. My basic linuxptp configuration is

   [global]
   gmCapable               1
   network_transport       L2
   delay_mechanism         P2P
   time_stamping           p2p1step

   [lan1]

   [lan2]


Issue 1
=2D------
PTP messages sent to address 01:80:C2:00:00:0E are not being received.
tshark displays the messages on the transmitting device, but not on the
receiving device. I don't know how close to the wire tshark gets in the
DSA architecture, but this suggests that the hardware is filtering the
messages.

I can work around this issue by adding

   p2p_dst_mac            01:1B:19:00:00:00

to the linuxptp configuration.


Issue 2
=2D------
The source port ID field in the peer delay request messages is being
modified. linuxptp sets it to 1 for the first port it uses (lan1 in my
example) and 2 for the second port (lan2). tshark shows these IDs on the
transmitting device, but on the receiving device shows the IDs have been
changed to the switch physical port number (so 2 and 3 in my case).
Again this suggests the hardware is changing the IDs on the fly. This
only happens for peer delay request messages - the other PTP messages
retain the linuxptp source port IDs.

I have checked that the "Enable IEEE 802.1AS Mode" bit is being set in
the KSZ9567 "Global PTP Message Config 1" register. According to the
datasheet

   When this mode is enabled, it modifies the IEEE 1588
   mode behavior. Primarily it causes all PTP messages to
   be forwarded to the host port, and the switch will not
   modify PTP message headers.

so if the hardware is responsible, both this and issue 1 look to be
device bugs.

I am currently working round this issue by patching linuxptp to use the
physical port numbers as the source port IDs. I can't think of a general
solution to this issue.

Issue 3
=2D------
When performing the port_hwtstamp_set operation, ptp_schedule_worker()
will be called if hardware timestamoing is enabled on any of the ports.
When using multiple ports for PTP, port_hwtstamp_set is executed for
each port. When called for the first time ptp_schedule_worker() returns
0. On subsequent calls it returns 1, indicating the worker is already
scheduled. Currently the ksz_ptp module treats 1 as an error and fails
to complete the port_hwtstamp_set operation, thus leaving the
timestamping configuration for those ports unchanged.

(note that the documentation of ptp_schedule_worker refers you to
kthread_queue_delayed_work rather than documenting the return values,
but kthread_queue_delayed_work returns a bool, not an int)

I fixed this issue by

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c
b/drivers/net/dsa/microchip/ksz_ptp.c
index 4e22a695a64c..7ef5fac69657 100644
=2D-- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -266,7 +266,6 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
         struct ksz_port *prt;
         struct dsa_port *dp;
         bool tag_en =3D false;
-       int ret;

         dsa_switch_for_each_user_port(dp, dev->ds) {
                 prt =3D &dev->ports[dp->index];
@@ -277,9 +276,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
         }

         if (tag_en) {
-               ret =3D ptp_schedule_worker(ptp_data->clock, 0);
-               if (ret)
-                       return ret;
+               ptp_schedule_worker(ptp_data->clock, 0);
         } else {
                 ptp_cancel_worker_sync(ptp_data->clock);
         }

CC'ing the authors of the ksz_ptp module as well as the ksz9477 driver
maintainers.

