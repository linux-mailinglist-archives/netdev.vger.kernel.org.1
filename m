Return-Path: <netdev+bounces-251861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK3PESnLcGkNZwAAu9opvQ
	(envelope-from <netdev+bounces-251861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:48:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3013570BF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C78665A5064
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710B47ECC2;
	Wed, 21 Jan 2026 12:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28553E9F7E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999193; cv=none; b=SWiKrssrGNqXa3ETLHOVqPKTBg0YsJYgJQYT4OAXK7YdTK+Wn71XRHNimHALDyQ5FjsntneMDQpSRkifXzuNPobSCXzQiOnQq7UDKz+9LoJAkPYS7vWkbSCwW2sjud7VupwnGsmuRAQgL8XGTVVNmGvmRe4iLSPw672J93Xt7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999193; c=relaxed/simple;
	bh=EiAFAOuMzwV4r2tGLN/QrCYwsZ2sDe6erK3vFeRjUb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gB2PdM2DA3V6hJzC86J/sMWkiy44caEOLpapAeKqP3HaC41nC9RlQzdTYVTUr9c0mFOabQuDzJ/90AlDvy/GIRrrW3z+QSJZ1PjvTpEwNP74MdJSe0NTqDZ+nkkDn/eUl302n//e/Ax3nER5bLeAdjMeN7rAgfZUAOu5aOgdKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1viXUk-001b9x-1d;
	Wed, 21 Jan 2026 12:39:33 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1viXUi-00000001N9M-0q4Q;
	Wed, 21 Jan 2026 13:39:32 +0100
Message-ID: <e4dcf5497e3840706b2e13d10c7efff1819c14a6.camel@decadent.org.uk>
Subject: Re: Bug#1126015: linux-image-6.17.13+deb14-rt-amd64: ethtool -x
 <sfc-net-driver-ifname> causes: rtmutex deadlock detected
From: Ben Hutchings <ben@decadent.org.uk>
To: Salvatore Bonaccorso <carnil@debian.org>, linux-net-drivers@amd.com, 
 Edward Cree <ecree.xilinx@gmail.com>
Cc: 1126015@bugs.debian.org, Damir Mansurov <damir.mansurov@oktetlabs.ru>, 
 netdev <netdev@vger.kernel.org>
Date: Wed, 21 Jan 2026 13:39:27 +0100
In-Reply-To: <aXBdvYZIePCFGtY9@eldamar.lan>
References: 
	<176891113233.1085.14440184213728685693.reportbug@elrond.oktetlabs.ru>
	 <176891113233.1085.14440184213728685693.reportbug@elrond.oktetlabs.ru>
	 <aXBdvYZIePCFGtY9@eldamar.lan>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-SHs7cU34VmZt4tx1w0v2"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-1.86 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251861-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[debian.org,amd.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oktetlabs.ru:email,decadent.org.uk:mid]
X-Rspamd-Queue-Id: E3013570BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-SHs7cU34VmZt4tx1w0v2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Control: tag -1 - moreinfo
Control: tag -1 upstream

On Wed, 2026-01-21 at 06:01 +0100, Salvatore Bonaccorso wrote:
> Control: severity -1 important
> Control: tags -1 + moreinfo
>=20
> Hi Damir,
>=20
> On Tue, Jan 20, 2026 at 03:12:12PM +0300, Damir Mansurov wrote:
> > Package: src:linux
> > Version: 6.17.13-1
> > Severity: critical
> > Justification: breaks the whole system
> > X-Debbugs-Cc: debian-amd64@lists.debian.org, damir.mansurov@oktetlabs.r=
u
> > User: debian-amd64@lists.debian.org
> > Usertags: amd64
> >=20
> > I am trying to read the receive flow hash indirection table from a NIC =
serviced by the sfc driver and I get a hung system.
> >=20
> > $ ethtool -x enp1s0f0np0
> > Jan 20 14:30:30 kernel: ------------[ cut here ]------------
> > Jan 20 14:30:30 kernel: rtmutex deadlock detected
> > Jan 20 14:30:30 kernel: WARNING: CPU: 2 PID: 1194 at kernel/locking/rtm=
utex.c:1674 __rt_mutex_slowlock_locked.constprop.0+0x1e8/0x220
> > Jan 20 14:30:30 kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_re=
solver nfs lockd grace netfs 8021q garp stp llc mrp binfmt_misc nls_ascii n=
ls_cp437 vfat fat intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal int=
el_powerclamp coretemp kvm_intel kvm jc42 dell_smbios ppdev dell_wmi_descri=
ptor platform_profile dcdbas irqbypass ghash_clmulni_intel mgag200 aesni_in=
tel drm_client_lib rapl drm_shmem_helper at24 drm_kms_helper intel_cstate i=
ntel_uncore vga16fb i2c_algo_bit vgastate pcspkr acpi_cpufreq parport_pc pa=
rport intel_vbtn sparse_keymap joydev ipmi_ssif evdev button ie31200_edac s=
g onload(OE) acpi_ipmi ipmi_si ipmi_watchdog sfc_resource(OE) ipmi_devintf =
ipmi_msghandler drm efi_pstore configfs auth_rpcgss sunrpc nfnetlink autofs=
4 ext4 crc16 mbcache jbd2 crc32c_cryptoapi hid_generic usbhid hid dm_mod sd=
_mod iTCO_wdt ahci intel_pmc_bxt iTCO_vendor_support watchdog tg3 libahci x=
hci_pci ehci_pci video sfc xhci_hcd libphy ehci_hcd wmi battery libata usbc=
ore mdio_bus mtd scsi_mod i2c_i801 fan usb_common i2c_smbus scsi_common
> > Jan 20 14:30:30 kernel:  lpc_ich
> > Jan 20 14:30:30 kernel: CPU: 2 UID: 1100 PID: 1194 Comm: ethtool Tainte=
d: G        W  OE       6.17.13+deb14-rt-amd64 #1 PREEMPT_{RT,(full)}  Debi=
an 6.17.13-1=20
> > Jan 20 14:30:30 kernel: Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUN=
SIGNED_MODULE
> > Jan 20 14:30:30 kernel: Hardware name: Dell Inc. PowerEdge R220/05Y15N,=
 BIOS 1.4.0 10/23/2014
> > Jan 20 14:30:30 kernel: RIP: 0010:__rt_mutex_slowlock_locked.constprop.=
0+0x1e8/0x220
> > Jan 20 14:30:30 kernel: Code: 00 4c 89 e6 48 89 ef e8 b6 35 ca 00 41 83=
 fd dd 0f 85 d7 fe ff ff 48 89 ef e8 f4 9c ca 00 48 c7 c7 6c 51 5d a9 e8 a8=
 00 f6 ff <0f> 0b 66 90 b8 01 00 00 00 87 43 18 e8 c7 3e fb ff eb ef bf 01 =
00=20
> > Jan 20 14:30:30 kernel: RSP: 0018:ffffcdc24208f5a0 EFLAGS: 00010246
> > Jan 20 14:30:30 kernel: RAX: 0000000000000000 RBX: ffff8b14d3888000 RCX=
: 0000000000000027
> > Jan 20 14:30:30 kernel: RDX: ffff8b1617f1ce88 RSI: 0000000000000001 RDI=
: ffff8b1617f1ce80
> > Jan 20 14:30:30 kernel: RBP: ffff8b14ca3d9150 R08: 0000000000000000 R09=
: ffffcdc24208f378
> > Jan 20 14:30:30 kernel: R10: ffffffffa9ee3e48 R11: 00000000ffffefff R12=
: ffffcdc24208f5a0
> > Jan 20 14:30:30 kernel: R13: 00000000ffffffdd R14: ffffcdc24208f648 R15=
: ffffffffa9168880
> > Jan 20 14:30:30 kernel: FS:  00007f1bb6609b80(0000) GS:ffff8b166d501000=
(0000) knlGS:0000000000000000
> > Jan 20 14:30:30 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> > Jan 20 14:30:30 kernel: CR2: 000055f2ef901700 CR3: 000000013b2c4001 CR4=
: 00000000001726f0
> > Jan 20 14:30:30 kernel: Call Trace:
> > Jan 20 14:30:30 kernel:  <TASK>
> > Jan 20 14:30:30 kernel:  rt_mutex_slowlock.constprop.0+0x4d/0xc0
> > Jan 20 14:30:30 kernel:  efx_mcdi_rx_pull_rss_config+0x28/0x60 [sfc]=
=20
> > Jan 20 14:30:30 kernel:  efx_ethtool_get_rxfh+0x3b/0xd0 [sfc]=20
> > Jan 20 14:30:30 kernel:  rss_prepare.isra.0+0x1c9/0x330
[...]
>=20
> Futhermore the kernel is tained with OOT module, afaics this might be
> sfc_resource. That is you still would need to check if the problem is
> trigerable without loading OOT module.

sfc_resource isn't involved in this (and nor is RT).  The deadlock seems
to be quite straightforward:

1. In net/ethtool/rss.c, rss_prepare_get() locks the net device's
   rss_lock and calls its driver's get_rxfh operation
2. In drivers/net/ethernet/sfc/ethtool_common.c, efx_ethtool_get_rxfh()
   calls the chip's rx_pull_rss_config operation
3. In drivers/net/ethernet/sfc/mcdi_filters.c,
   efx_mcdi_rx_pull_rss_config() locks the net device's rss_lock

Step 3 seems to be a workaround for missing locking in the ethtool core.
Since that locking was added to the ethtool core in 6.17, it needs to be
removed from the sfc driver from that version onward.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett

--=-SHs7cU34VmZt4tx1w0v2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmlwyP8ACgkQ57/I7JWG
EQkK1BAAkfPsvGbrnIgmDCC/2225k9Uue3dsyd1a+UUn20UrJ1iQTMDeLFk04laR
Zptg1wHuhTtg/btr4lfPiCfxekgKgBEvyoFrSoCexUa+fH71PcH2nIteSydjLDVO
Eyl9iSIAyD+8foGtO8PEJMZ1Aa6Fw3GIPIA1m+tYR9aqP94MCk0ZnyTazghbxAUO
/lj0D3hCr3YWtXZAQl8YArPk/wbd4WLRtu1isjtXOjTvqhiL3V1jUz9ElikAAvRR
kVOvngeqlJ5JWm3BWXnMfLqUrGX0hnMXLUlValzxVQwaNjU8W1k29MylAiTcYYwd
opEpf5FjlZ4q16XZo+4QqlvJHM+RQvjf6WokR2fGG9hmgdhltM1WJQACDYombr2m
3vXZY4IA/h6pCFEK4FkaGhTKILZhhFSM6DJSGM9JbGr2RXSs+vo9OuwIM6JmhJez
F6vLTeBvRm0eGzLomgSzNzJmehLsq49vOepIILzumLtNSku+AzP6n87vm4TJqmfX
RuvwCXdFfZJwL8VlsI1ZWecHXnp25zTLN7IH1/duIVVxbZVAEoK5klKApK6YTwLM
47+7vJWKgir2Uc4WYd7HVzc4mKS4ilsJnyEZBB1nGdYLPXQqmRPR1LWBvggw/zZT
9oiwjmTR90+wt5x0OmRNyFjXiK/Esr4HgNr5ck0DCfZC9EFvjv0=
=oU0W
-----END PGP SIGNATURE-----

--=-SHs7cU34VmZt4tx1w0v2--

