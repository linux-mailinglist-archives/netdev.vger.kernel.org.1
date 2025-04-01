Return-Path: <netdev+bounces-178645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321CA7807C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBB3166DE9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79120D517;
	Tue,  1 Apr 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="lT4hQ8Jp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789F20D4F6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525047; cv=none; b=SO7X/oOediq/tvyCm7uXhIwgGM3o33Tc53YGKZeicgwMOUsG9+vzhGQ6TuIP2enJm6c7mp9ZkMWnbRxy/6f5hrmX2uwv0HFA7tRVWmqBVvmT/dqAwzbb9TtudjutZ6gnmHqCdgc4JvBYs5J303gd0rChm+NwaS5hrIdvgjwsHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525047; c=relaxed/simple;
	bh=WW3nu6KzgsPeLsLxy3Wgc9nNsHDQgS0gktfXMmLlS1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q4OxKhxRO2FZ9UihiXmjT5KbsvQQ7Yt4oKvAK3E12XO7GzoYUUJuIZ/QjDI6CGVIFdswqL84dIixS+oTkWZSQ7GlAJrjYa2muDSXe+nDNzVYsEcpL71b+0oNjWqrFLU4cdGpvrdSMgIVJpShR4OXvHgTghvJO/AXJIWfxMejvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=lT4hQ8Jp; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743525035; x=1743784235;
	bh=+7Do12VfIiKrGfPsYu9Gte5UkMRRTNhdO0sLTH4l5Bw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=lT4hQ8Jpy+oEEM2/VfM01Zr5ce7tNPyFFyNLL8FKlTRnEy9+GsVACtENwGdXxxHAv
	 ly/odcxvYQU7wkrUwuXBsZU/8ofDUJivijwrczyXSQib3e92iEL9iBvgWMLIHZoQTT
	 IezWRGDQxMv3bdAzP0jRt+yCyc3iLMdI/w2ehld4uDwXMGBHaiwqVCxlXfU/GswWvs
	 bqG2SUJF+sgJxye1JQD4SenoPQRFU+zkCbT5ZWzCjnesI9c4YG6VOfABfKFCC1Zrnf
	 MjFI5XUzrOylecw9Ys1qUBAHwDUUMjhSRO4HlA52SID1Gvwaoud9d8mtpAk6Enafb3
	 Df2evwIuvmAVg==
Date: Tue, 01 Apr 2025 16:30:30 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: I have FINALLY SUCCEEDED in getting Palo Alto VM-Series Software Firewall 10.0.4 to work in Ubuntu Desktop 22.04.5 LTS KVM Host
Message-ID: <w-vSvJ1CEeQo-3EplTRQeiIgtT7x20Pk89dGwGAfApgvgoPO6aKk2739taptvtxkLqkgLn84ICgfSmNmYgX827_wt9CJuqI5ery3YWh-AzE=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 0d1f40840f789016aa6b44e3a695f4ff8df895fc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: I have FINALLY SUCCEEDED in getting Palo Alto VM-Series Software F=
irewall 10.0.4 to work in Ubuntu Desktop 22.04.5 LTS KVM Host

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 2nd April 2025 Wednesday

I have FINALLY SUCCEEDED in getting Palo Alto VM-Series Software Firewall 1=
0.0.4 to work in Ubuntu Desktop 22.04.5 LTS KVM Host.

Below are my FINAL notes.

cd /etc/netplan/
sudo nano 01-netcfg.yaml

My FINAL netplan configuration:

network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: no
    enp2s0:
      dhcp4: no
    enp3s0:
      dhcp4: no
    enp4s0:
      dhcp4: no
  bridges:
# Management interface
    br0:
      interfaces: [enp1s0]
      dhcp4: yes
# WAN interface
    br1:
      interfaces: [enp2s0]
      dhcp4: yes
# LAN interface
    br2:
      interfaces: [enp3s0]
      dhcp4: no
      addresses: [192.168.1.254/24]
# Unused interface for the moment, maybe DMZ in the future
    br3:
      interfaces: [enp4s0]
      dhcp4: yes

sudo netplan apply
sudo systemctl restart NetworkManager

sudo brctl addif br0 enp1s0
sudo brctl addif br1 enp2s0
sudo brctl addif br2 enp3s0
sudo brctl addif br3 enp4s0

teo-en-ming@PA-VM:/etc/netplan$ sudo brctl show
bridge name=09bridge id=09=09STP enabled=09interfaces
br0=09=098000.da16c5ba83c0=09yes=09=09enp1s0
br1=09=098000.2a1de38524c1=09yes=09=09enp2s0
br2=09=098000.2ac0bc028fe3=09yes=09=09eno1
br3=09=098000.4eb2b8fe7743=09yes=09=09enp4s0
virbr0=09=098000.525400f9e6d6=09yes=09

You should use virtio for all of your Linux bridges in Virtual Machine Mana=
ger (GUI). virtio has been verified to work.=09

Interface Mappings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Port 1 on the hardware appliance maps to the Management interface eth0
Port 2 on the hardware appliance maps to the WAN interface ethernet1/1
Port 3 on the hardware appliance maps to the LAN interface ethernet1/2
Port 4 on the hardware appliance maps to the DMZ interface ethernet1/3 (to =
be implemented in the future)

Congratulations to myself!

My next project: I am planning to download, install and configure Check Poi=
nt CloudGuard Virtual Firewall in Ubuntu Linux KVM host!

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
2nd April 2025 Wednesday 12.25 AM





