Return-Path: <netdev+bounces-178445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C7A770D4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28973167F64
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8837221A428;
	Mon, 31 Mar 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fm16aIjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch [109.224.244.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BB42A94
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743459756; cv=none; b=cRmU4vB4dLkDoXHRYXyWLcfIYk9F7wpzI3XxE00OMBydILIblLt593ptLkpg0gMo/8UwiBxRpHr6t+iIGDv4hTNbkmIDnCjDe+82Qvea7SvKWFcxT9bC+8HEygIg7Fq++/U0PcR6K3xhl2iTouHhPt+qJ+IlTDOq1Db03Ur3Dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743459756; c=relaxed/simple;
	bh=gGzgiTvXQQibZ+ERzRwwxgHi50AUO/I+7vx93+o07d4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IjriA6G1IJ2RJ2jeVZY5scBDE+S5drXemYsLxL8iKIj9TxB8uGyHGYEG9B6Tzw7mO1y1Ni4Em6fUxnWf3355UbZE75rF89R9r1AToMhnnQ6o0XFUISBVMl1jo/nboAmaCivUpo/mB9/ggq93wrtevXCaAmc124i1V7tK9iZtOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fm16aIjr; arc=none smtp.client-ip=109.224.244.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743459746; x=1743718946;
	bh=Nxy07cmWokL1xUwGoARaDrFRBW2Ukg+q1AJmS9EGCs0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=fm16aIjrCukTMj5VVVhpAe1iAsu97ziHBF6l9GXj5qGKKe0oII+S7fJH7YUTadCLW
	 6395cgfAv6lhO5xYE+poU+fcVJ41MRYiVBfTrRfGAJauz800gV4t1bmS3uAsx7CwOA
	 8N2zUQh+9MLEQBNf4m0DyWrufi60IavYO7ISN0m0ZQw02Y89RVTuw7HEyJB68qLQpk
	 P4hWTRDAUOWVog9snHzb2X2Q503rVibj39SH/d6uGJlnpSr6HkeLvSyM70KyC/Z9jc
	 CvOpvCkBsPtNIHRslNKR+SA79D+yZZW6aLH0n0ynVHAZTCclDbeGrnjrfFoQIlgMKB
	 zgq2UMAk/WaFw==
Date: Mon, 31 Mar 2025 22:22:19 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Overall Summary of Installing and Configuring Palo Alto VM-Series Software Firewall 10.0.4 in Ubuntu Desktop 22.04.5 LTS KVM Host
Message-ID: <W7-9ud6OsKlsNj2TxreqwNR_nZuD6PvhV8zMRFNgZd67mh1eKrzugdgVtRJOouvoJ0tXr3ksDXF6QiSr6s7qBASErhpZT-oRrOlizjTFcJU=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: bb1ebea3f4112c947d6799dc19d921c60cfaaf97
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Overall Summary of Installing and Configuring Palo Alto VM-Series =
Software Firewall 10.0.4 in Ubuntu Desktop 22.04.5 LTS KVM Host

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 31 Mar 2025 Monday

DETAILED INSTRUCTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Download and install Ubuntu Desktop 22.04.5 LTS on a hardware appliance wit=
h 3 or 4 network interface cards.

Please *DO NOT* install and run openssh-server, as Advanced Persistent Thre=
ats (APT) hackers may use this avenue to hack into your Ubuntu KVM host.

On the morning of 30 March 2025 Sunday, Advanced Persistent Threats (APT) h=
ackers hacked into my previous installation of Ubuntu KVM host and changed =
my netplan
configuration. The APT hackers removed all the network interfaces from the =
network bridges. I have since erased and reinstalled my Ubuntu Desktop 22.0=
4.5 LTS KVM host.

Install KVM and Dependencies
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Run the following command to install KVM, Virt-Manager, and dependencies:

sudo apt update && sudo apt upgrade -y

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-u=
tils virt-manager

Verify if KVM is installed:

sudo kvm-ok

INFO: /dev/kvm exists
KVM acceleration can be used

Start and enable the libvirt service:

sudo systemctl enable --now libvirtd

Download and Prepare the QCOW2 Image
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Download the Palo Alto VM-Series software firewall QCOW2 image from Palo Al=
to Networks.

The filename of my image is PA-VM-KVM-10.0.4.vm_eval.qcow2.=20

Copy the image to the KVM images directory:

sudo cp PA-VM-KVM-10.0.4.vm_eval.qcow2 /var/lib/libvirt/images/

Adjust file permissions:

sudo chown libvirt-qemu:kvm /var/lib/libvirt/images/PA-VM-KVM-10.0.4.vm_eva=
l.qcow2

sudo chmod 644 /var/lib/libvirt/images/PA-VM-KVM-10.0.4.vm_eval.qcow2

Configuring Multiple Interfaces for the Palo Alto VM-Series software firewa=
ll
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

To configure ***multiple interfaces*** for the Palo Alto VM-Series firewall=
 on Ubuntu KVM, follow these steps:

Identify Network Interfaces
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

First, determine the network interfaces available on your KVM host using:

ip link show

You'll need at least:

    1 interface for management

    1 or more interfaces for data traffic (inside, outside, DMZ, etc.)
   =20
Create Network Bridges=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you want Palo Alto firewall to be on different networks, create Linux br=
idges.

Install bridge utilities:

sudo apt install bridge-utils

Configure bridges in Netplan (/etc/netplan/01-netcfg.yaml):

sudo nano /etc/netplan/01-netcfg.yaml

My netplan configuration:

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
    br0:
      interfaces: [enp1s0]
      dhcp4: yes
    br1:
      interfaces: [enp2s0]
      dhcp4: no
    br2:
      interfaces: [enp3s0]
      dhcp4: no
    br3:
      interfaces: [enp4s0]
      dhcp4: no
     =20
cd /etc/netplan

sudo chmod 600 01-netcfg.yaml
     =20
Apply changes:

sudo netplan apply

sudo brctl show

bridge name=09bridge id=09=09STP enabled=09interfaces
br0=09=098000.da16c5ba83c0=09yes=09=09enp1s0
br1=09=098000.2a1de38524c1=09yes=09=09enp2s0
br2=09=098000.2ac0bc028fe3=09yes=09=09
br3=09=098000.4eb2b8fe7743=09yes=09=09
virbr0=09=098000.525400f9e6d6=09yes=09

Perform a reboot of Ubuntu KVM host.

sudo reboot

Create a Virtual Machine Using Virt-Manager (GUI)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Use the following guide.

Guide: VM-Series Deployment Guide: Provision the VM-Series Firewall on a KV=
M Host
Link: https://docs.paloaltonetworks.com/vm-series/10-0/vm-series-deployment=
/set-up-the-vm-series-firewall-on-kvm/install-the-vm-series-firewall-on-kvm=
/install-the-vm-series-firewall-using-virt-manager/provision-the-vm-series-=
firewall-on-a-kvm-host

Start the Virtual Machine Manger (GUI).

sudo virt-manager

Configure the Palo Alto firewall virtual machine as per above guide.

You need to set the date of PA-VM 10.0.4 virtual machine to 12 Sep 2021, wh=
ich is 111833956 seconds ago.

sudo virsh edit PA-VM-KVM-10.0.4

  <clock offset=3D'variable' adjustment=3D'-111833956' basis=3D'utc'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/>
  </clock>

Start the virtual machine in Virtual Machine Manager (GUI).

sudo brctl show
bridge name=09bridge id=09=09STP enabled=09interfaces
br0=09=098000.da16c5ba83c0=09yes=09=09enp1s0
=09=09=09=09=09=09=09vnet4
br1=09=098000.2a1de38524c1=09yes=09=09enp2s0
=09=09=09=09=09=09=09vnet5
br2=09=098000.2ac0bc028fe3=09yes=09=09vnet6
br3=09=098000.4eb2b8fe7743=09yes=09=09vnet7
virbr0=09=098000.525400f9e6d6=09yes

You MUST wait for PA-HDF login prompt to change to PA-VM login prompt. The =
waiting time is usually around 10 minutes.

Open your web browser and access the Palo Alto VM-series firewall web login=
 page at https://<IP address>

Login with the default username and password of admin/admin.

Change the admin password immediately.

Configuring the Palo Alto VM-Series Software Firewall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Use the following 2 guides.

Guide 1: Example Configuration for Palo Alto Network VM-Series in GCP
Link: https://docs.aviatrix.com/documentation/latest/security/paloalto-vmse=
ries-gcp.html

Guide 2: Setting up a Palo Alto Networks Firewall for the First Time
Link: https://rowelldionicio.com/setting-up-palo-alto-networks-firewall-fir=
st-time/

Please note that Guide 2 is more detailed and comprehensive.

Outstanding Issues / Issues Pending to be Resolved
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

As of 31 Mar 2025 Monday at 4.34 PM, when I connect my laptop to Port 2 on =
my hardware appliance, which is mapped to network bridge br1, which is in t=
urn mapped to ethernet1/2 (LAN) in the Palo Alto VM-Series software firewal=
l, there is still no network connectivity at all. I can't get an IP address=
 from the Palo Alto firewall DHCP server and I can't ping the LAN gateway 1=
92.168.1.1 at all.

Currently the network bridge mapping is:

br0 =3D> ethernet1/1 (WAN)
br1 =3D> ethernet1/2 (LAN)

Perhaps there could be issues with Port 2 on my hardware appliance, or the =
network bridge br1 may not be working properly. I have flushed all the ipta=
bles firewall rules on the Ubuntu KVM host and there is still no network co=
nnectivity between my laptop and Port 2 on the hardware appliance.

I suspect I could have done the network bridge mapping wrongly and this cou=
ld turn out to be the real scenario:

br0 - MANAGEMENT - ethernet1/1
br1 - WAN - ethernet1/2 (untrust, outside)
br2 - LAN - ethernet1/3 (trust, inside)

If I have done the network bridge mapping wrongly, I will have to configure=
 the Palo Alto VM-Series firewall all over again.

Let me check with Palo Alto Networks technical support. At the mean time, p=
lease advise whether my netplan configuration for my Ubuntu KVM host is cor=
rect or not.

Lastly, the command for connecting to the console of Palo Alto VM-Series so=
ftware firewall.

sudo virsh console PA-VM-KVM-10.0.4

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
31 March 2025 Monday 5.15 PM






