Return-Path: <netdev+bounces-295472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cr9cBWYEImprRgEAu9opvQ
	(envelope-from <netdev+bounces-295472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:04:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657E643E2A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 01:04:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bTw/Ql6o";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295472-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295472-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2923300CBE1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 23:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7A305679;
	Thu,  4 Jun 2026 23:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF24223DFF
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:03:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614239; cv=pass; b=dpnAltlHz6HfEZgR1EsJLnf9MnydbrHlVhk8MIelna1xszj6AYBvoBdXF5geI4Mdy/cIwPQd//7bThiKCcRItMOHc2QFyqbawJZyBHfcnnZLYcC8qbLz0diFFpnOm0jBUzxp5EblDU0SQ2QEiswoZEKECyoLULHfuzVM1SNkcBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614239; c=relaxed/simple;
	bh=8VVzTnpr6sr448AdIXHpM9xttLzFvN3PyButU+GWopw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In4ShFnkzHOQ2UlmQIpPr+K4tuPdyhSdyj4KBiacukkC84H/1vzIz48pzgJYtjQCiyC/RBf7jlh2aLxcTXAtYW4i7BFVYtGfucHtkyhtNgiI2V6odg7yIwXKBrnIB1rPjF0xfcQ6t/MRAJ1JES2KwZOQehGfl7m+cxCEF3OX+j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTw/Ql6o; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so1977998a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780614235; cv=none;
        d=google.com; s=arc-20240605;
        b=O5aYdoFCBwFOx+RJARKR7EMFRe0YAOtB8XvRpQWTV343OGtbhhZVNdKMgKlE9AS6sQ
         vPH3zykZyqBOul8yP2v9liI7OI5Vf6G8DnkKwEKBhldjI7oYwql7iNQkzVReuwMAzGIP
         8uVDoqQz0sVG8jGZp40jhUN7ieNUw/Y8tyNiaQxsHIUJXycoSkEmhBz/lllh4gJkWA0e
         K+yaFmTzvwzKrzY5f4ce25fUCrdDzhiGG7JqvA1GXdIUfubO5pmmOBKnxEaPe2c2gvbW
         MQE5JfedJ/sf0aWzHNmomHoDQiK02LL1p0yvzp+cNug8IuYtQviprWEuIeTSFlPP+KRc
         IJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QfopuS14YkMJsw4Oj3aqo+ryjVD/nWiH6VMnm1UtOrM=;
        fh=Nb4wS0Yg4RGu8gSKoSAsY4Pvo3UrZw19D6XsmEEx+l4=;
        b=du7M9lvo8WvAZyX9yh2OrxWFunC52240dqiKpjTHq0S5GwUlevKVyLzWi7zAh/lkTU
         gLyMljX1oKdld6N7wZNaBR2uKbwrHqGDrlSivP+n2P8+FDOwXa0NhT93rsl9zACB+Aw7
         eRCL5sHsVJgw4+3mSYXTBDxvS7UPizLFUIrlxr7Bz+sXTFltXxWkb2s+o/XZgeTm0jBP
         i5FHuKHYx86ig/lCppwL1BBDpk0xbmhL1k8w/DYKWuc6aM7QbG8bogefuixeV0yJRBec
         GnHltz9iDAVd8ul7gmQDFzdgveAhgi3BT5cL3BQZ6pRHlZ3C7hP2ZF+/v199/dnybD05
         KIaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780614235; x=1781219035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfopuS14YkMJsw4Oj3aqo+ryjVD/nWiH6VMnm1UtOrM=;
        b=bTw/Ql6oK6BuWAHGdbE8Htdi0QbFWiiHX2YNwimJqZITOinHaDpXuaGV5uBxauIcew
         3C8ImVWv29NyJBWjhlX8N1wlikvyvNF/PUEvQQSimTN0F6XpEVXrKhLjdZKBi9QL9ZMx
         Lka/k6w2t5nMsq7pEvja6szg4bBCTXqWYpVqa93w0dMudC++gmMj36HH5LJYMT97Zj79
         HE5w4VmJb3Np958/nMsDHQHLQlsR3qoPteV4cjMRajPY8dxYa+fue1lEHwt3vfNfttu6
         j54iRY6acGwOAgAVtVexO06v9bwTr2+yUDPHG39M5zIz2bs6NYBsUOpNJNwr+UVDvuOB
         ymOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614235; x=1781219035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfopuS14YkMJsw4Oj3aqo+ryjVD/nWiH6VMnm1UtOrM=;
        b=MlQZIV/r5R7PYk03g5AYEimQMu0LmmGBj/JDpBu6zAFFsURxm90Cywl462gZ9ydEYA
         mfQlrQ936DPa1BvQ1wKzIP/m0adKt+gAMgicMSQ8TjHg7FqYq2SmhDNA0hcEuVOHIOVT
         q521cqDzJqZxpUo+chfMVTbaIYKiLTSiMLtu8y+O4KsVgpDThe18bVIXvnyVwOa54PTT
         vXyg2qYr8iqWY3WVkFeyECBBP7G7b5ycpOqr/xzQNq6sKAcgITO5kmkDKtK0qqAGjYbb
         7SEFTHw8tnJe0f7qFGMVlESikGAQtNgnDvp44CPToiwq4+gdUIt2UoWaVpJhRt+1m3Lj
         NEGA==
X-Gm-Message-State: AOJu0Yyfl7pQYeZudbf3Ibfve3p8HcLs5qp9MGffa2pWYs1mx0ILoqfq
	mkBJziRggXOwfpDQJbhrP8dw/3zTUd87FtgAsr5e8W0sYRv3sCypn5zTvmDD0xXiqY/3XeiD2SX
	yHxNyJY6rwhYU3xVpRAIkLJtITGNO3Pg=
X-Gm-Gg: Acq92OFbXOI3Par7iQuaxf5I6ZVZKAWPw+ovtknjv6RxKnLDTF0cLuQNn+bCyb6QpFW
	iTtzPcSr+FPv8rTVF2OdYF3NqHazrnjZur7FwsfsyKDvtJiPA+rJ58t1n9FsxZ0NThp+CSs2Rpw
	l3/2RNRnNE1rhLXLNHrfEvBNECzOdaxoeRqFl4W6aEN+zQh70l87iS/RDyRdQv0/+0j/2tzyu+A
	05CzZJGR2ECwaVt+6hy+kvp3c4W/HSguVUY/rKuqrgg74zOUqfPTCxe+F9m5Rkp+7eDr8ElCc3T
	78UeY995EdkKubd7/mDg+xo5EiYJPZalY9dUG42yA3YaC+lyfbYgLCxXo8H6E+MeT8z4pKy7m9Y
	LEPz39nVsv0OD1AJNzcCXK7RwB0APfSs3UnEb99S9yUjFhqWlHjlwzQibrOkxz8DGNcwT
X-Received: by 2002:a05:6402:51cc:b0:680:b3ed:c5b with SMTP id
 4fb4d7f45d1cf-68fa503bae3mr434408a12.14.1780614235036; Thu, 04 Jun 2026
 16:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603230821.5619-1-rosenp@gmail.com> <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
In-Reply-To: <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 4 Jun 2026 16:03:43 -0700
X-Gm-Features: AVHnY4Ktibqc3Pvokjp2TvMEBEFfMGCmJsuCRCsY06dIXlkiNOzwDhRXloQGgNA
Message-ID: <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in mal_remove()
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jeff@garzik.org>, 
	Roland Dreier <rdreier@cisco.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295472-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6657E643E2A

On Thu, Jun 4, 2026 at 11:52=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 6/3/2026 4:08 PM, Rosen Penev wrote:
> > napi_disable() is not idempotent and calling it on an already-disabled
> > or unenabled NAPI context will cause the kernel to spin indefinitely
> > waiting for the NAPI_STATE_SCHED bit to clear.
> >
> > In mal_remove(), napi_disable() is called unconditionally. If no MACs w=
ere
> > registered, NAPI was never enabled. Also, if they were registered but
> > subsequently unregistered, NAPI was already disabled in
> > mal_unregister_commac(). In either case, calling napi_disable() causes
> > the kernel to hang upon module removal.
> >
> > Fix this by only calling napi_disable() in mal_remove() if the commac l=
ist
> > is not empty (which implies NAPI is enabled).
> >
> > Fixes: 59e90b2d2250 ("ibm_emac: Convert to use napi_struct independent =
of struct net_device")
> > Assisted-by: antigravity:gemini-3.5-flash
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/mal.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet=
/ibm/emac/mal.c
> > index 83dd7f99d8d5..74526002d52b 100644
> > --- a/drivers/net/ethernet/ibm/emac/mal.c
> > +++ b/drivers/net/ethernet/ibm/emac/mal.c
> > @@ -712,13 +712,13 @@ static void mal_remove(struct platform_device *of=
dev)
> >       MAL_DBG(mal, "remove" NL);
> >
> >       /* Synchronize with scheduled polling */
> > -     napi_disable(&mal->napi);
> > -
> > -     if (!list_empty(&mal->list))
> > +     if (!list_empty(&mal->list)) {
> > +             napi_disable(&mal->napi);
> >               /* This is *very* bad */
> >               WARN(1, KERN_EMERG
> >                      "mal%d: commac list is not empty on remove!\n",
> >                      mal->index);
>
> This one doesn't make sense to me. The list_empty check does a WARN()
> indicating that this is not supposed to happen.
>
> This implies that list_empty should be true, otherwise we'd see a WARN
> every time mal_remove is called.
>
> But in that case, we'd have been calling napi_disable incorrectly in
> most cases where it was previously unsafe according to your claim.
>
> At best, this list_empty check is the wrong way to tell if the napi is
> disabled, at worst, this whole change is pointless.
I asked the AI. It doesn't agree:

Now I have a clear picture. Let me trace through the full lifecycle:
NAPI enable/disable invariant:
- mal_register_commac() (line 52-56): if list_empty, napi_enable =E2=86=92
list_add =E2=86=92 NAPI enabled iff !list_empty
- mal_unregister_commac() (line 75-77): list_del_init =E2=86=92 if list_emp=
ty,
napi_disable =E2=86=92 same invariant holds
- mal_probe() (line 582-592): INIT_LIST_HEAD(&mal->list),
netif_napi_add_weight() =E2=80=94 list empty, NAPI starts disabled
This is a correct, deliberately maintained invariant throughout the
driver. !list_empty(&mal->list) is the right way to check whether NAPI
is enabled.
The reviewer's objection:
This implies that list_empty should be true, otherwise we'd see a WARN
every time mal_remove is called.
Yes, and that's correct =E2=80=94 in normal operation, all child commacs
unregister before the parent MAL device is removed (driver model
guarantees this). So the list is empty in the normal case.
But in that case, we'd have been calling napi_disable incorrectly in
most cases where it was previously unsafe according to your claim.
This is where the reviewer goes wrong. The unconditional
napi_disable() was causing a hang in the normal case =E2=80=94 that's the
entire point of the patch. napi_disable() is not idempotent: calling
it when already disabled spins on NAPI_STATE_SCHED forever. The hang
only manifests on rmmod/device unbind, which is why it wasn't caught
in normal testing.
At best, this list_empty check is the wrong way to tell if the napi is disa=
bled
It's actually the exact same check used in both mal_register_commac
and mal_unregister_commac to manage NAPI state. The invariant is
strict.
The patch is correct:
Case Before (unconditional) After (conditional)
No commac ever registered HANG =E2=80=94 napi_disable on never-enabled NAPI
skip =E2=80=94 list empty =E2=9C=93
Commac registered & unregistered HANG =E2=80=94 napi_disable already called=
 by
unregister skip =E2=80=94 list empty =E2=9C=93
Commac registered, not unregistered (error) napi_disable called
(correct, napi is enabled) + WARN napi_disable called (correct) + WARN
=E2=9C=93
The fix prevents two real hang scenarios while preserving the
error-path behavior.

The hint to unbind the driver was key. I tried it:

root@OpenWrt:~# echo plb:mcmal >
/sys/bus/platform/drivers/mcmal/unbind [ 102.026306] ------------[ cut
here ]------------ [ 102.033965] mal0: commac list is not empty on
remove! [ 102.039179] WARNING: CPU: 0 PID: 2136 at
mal_remove+0x44/0x94 [ 102.044935] Modules linked in: ath9k(O)
ath9k_common(O) nft_fib_inet nf_flow_table_inet ath9k_hw(O) ath(O)
nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir
nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash
nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct
nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mac80211(O)
cfg80211(O) spi_gpio spi_bitbang nfnetlink nf_reject_ipv6
nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 crc_ccitt
compat(O) ledtrig_usbport sha512 libsha512 sha256 sha1 seqiv drbg hmac
geniv cmac usb_storage leds_gpio dwc2 roles sd_mod scsi_mod
scsi_common gpio_button_hotplug(O) usbcore nls_base usb_common
crypto4xx crc32c_cryptoapi [ 102.107571] CPU: 0 UID: 0 PID: 2136 Comm:
ash Tainted: G O 6.18.31 #0 NONE [ 102.115984] Tainted: [O]=3DOOT_MODULE
[ 102.119464] Hardware name: Meraki MX60/MX60W Security Appliance
APM821XX 0x12c41c83 PowerPC 44x Platform [ 102.128908] NIP: c0555900
LR: c0555900 CTR: c04ace1c [ 102.133945] REGS: c14cbcc0 TRAP: 0700
Tainted: G O (6.18.31) [ 102.141314] MSR: 00029000 <CE,EE,ME> CR:
28008242 XER: 20000000 [ 102.147491] [ 102.147491] GPR00: c0555900
c14cbdb0 c237ae80 00000029 3fffefff c14cbc74 c14cbc68 00000000 [
102.147491] GPR08: 00000001 c0a90000 00000000 ffffefff 48008242
00000000 10072408 b7d7dfd4 [ 102.147491] GPR16: 00000002 bfc0bc70
b7d7e4ac 00000000 b7d7e494 00000002 00000000 00000020 [ 102.147491]
GPR24: 10080000 00000000 c3154970 c10f9810 c0a9b9b4 c0a9b9b4 c1102600
c12b9020 [ 102.182320] NIP [c0555900] mal_remove+0x44/0x94 [
102.186838] LR [c0555900] mal_remove+0x44/0x94 [ 102.191271] Call
Trace: [ 102.193707] [c14cbdb0] [c0555900] mal_remove+0x44/0x94
(unreliable) [ 102.199962] [c14cbdd0] [c04c790c]
device_release_driver_internal+0x1ec/0x28c [ 102.206995] [c14cbe00]
[c04c4ae0] unbind_store+0x70/0xc8 [ 102.212292] [c14cbe20] [c02a08f4]
kernfs_fop_write_iter+0x18c/0x268 [ 102.218556] [c14cbe50] [c02093cc]
vfs_write+0x280/0x4a8 [ 102.223783] [c14cbec0] [c02097bc]
ksys_write+0x78/0x138 [ 102.229001] [c14cbef0] [c000a498]
system_call_exception+0x84/0x148 [ 102.235178] [c14cbf00] [c000d0ac]
ret_from_syscall+0x0/0x28 [ 102.240744] ---- interrupt: c00 at
0xb7d59ef0 [ 102.245089] NIP: b7d59ef0 LR: b7d423a8 CTR: b7d59d44 [
102.250127] REGS: c14cbf10 TRAP: 0c00 Tainted: G O (6.18.31) [
102.257495] MSR: 0002f900 <CE,EE,PR,FP,ME> CR: 20002442 XER: 20000000
[ 102.264200] [ 102.264200] GPR00: 00000004 bfc0b8d0 b7d850c0 00000001
b7d7ee60 0000000a 00000000 00000000 [ 102.264200] GPR08: 00000000
00000000 bfc0bfe8 b7d59d44 10009684 00000000 10072408 b7d7dfd4 [
102.264200] GPR16: 00000002 bfc0bc70 b7d7e4ac 00000000 b7d7e494
00000002 00000000 00000020 [ 102.264200] GPR24: 10080000 10080000
10080000 10080000 00000000 b7d7e050 b7d83b4c 00000004 [ 102.299028]
NIP [b7d59ef0] 0xb7d59ef0 [ 102.302683] LR [b7d423a8] 0xb7d423a8 [
102.306251] ---- interrupt: c00 [ 102.309380] Code: 93e1001c 83e30050
387f0030 48066771 7fe9fb78 85490150 7c0a4840 41820018 809f0170
3c60c093 3863c034 4bad2569 <0fe00000> 7fe3fb78 4bffff01 807f0174 [
102.324076] ---[ end trace 0000000000000000 ]--- root@OpenWrt:~# [
107.359539] BUG: Unable to handle kernel data access on write at
0xe102d13c [ 107.366514] Faulting instruction address: 0xc05597d4 [
107.371463] Oops: Kernel access of bad area, sig: 11 [#1] [
107.376843] BE PAGE_SIZE=3D4K PowerPC 44x Platform [ 107.381535] Modules
linked in: ath9k(O) ath9k_common(O) nft_fib_inet nf_flow_table_inet
ath9k_hw(O) ath(O) nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet
nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log
nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib
nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack
mac80211(O) cfg80211(O) spi_gpio spi_bitbang nfnetlink nf_reject_ipv6
nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 crc_ccitt
compat(O) ledtrig_usbport sha512 libsha512 sha256 sha1 seqiv drbg hmac
geniv cmac usb_storage leds_gpio dwc2 roles sd_mod scsi_mod
scsi_common gpio_button_hotplug(O) usbcore nls_base usb_common
crypto4xx crc32c_cryptoapi [ 107.444172] CPU: 0 UID: 0 PID: 1383 Comm:
odhcpd Tainted: G W O 6.18.31 #0 NONE [ 107.452845] Tainted: [W]=3DWARN,
[O]=3DOOT_MODULE [ 107.457186] Hardware name: Meraki MX60/MX60W Security
Appliance APM821XX 0x12c41c83 PowerPC 44x Platform [ 107.466631] NIP:
c05597d4 LR: c05597c8 CTR: 00000000 [ 107.471668] REGS: c14cd520 TRAP:
0300 Tainted: G W O (6.18.31) [ 107.479036] MSR: 00029000 <CE,EE,ME>
CR: 48022802 XER: 00000000 [ 107.485215] DEAR: e102d13c ESR: 00800000
[ 107.485215] GPR00: c05597c8 c14cd610 c1157640 00000000 014a2278
00000001 00000001 00000000 [ 107.485215] GPR08: 00000006 e102d138
00000003 ffffffff 00000000 00000000 00a8e710 00000001 [ 107.485215]
GPR16: 00000000 bf853ab4 00000000 00000001 00000000 0000003a c0aa0000
c13a3110 [ 107.485215] GPR24: 00000000 c1108210 c1108200 ffff9300
c14a2278 000000b0 00000138 c13a3000 [ 107.522548] NIP [c05597d4]
emac_start_xmit+0xe4/0x280 [ 107.527611] LR [c05597c8]
emac_start_xmit+0xd8/0x280 [ 107.532562] Call Trace: [ 107.534999]
[c14cd610] [c05597c8] emac_start_xmit+0xd8/0x280 (unreliable) [
107.541772] [c14cd640] [c055ac60] emac_start_xmit_sg+0x48/0x620 [
107.547682] [c14cd690] [c05c4d40] dev_hard_start_xmit+0x150/0x1ac [
107.553765] [c14cd6d0] [c0625ed4] sch_direct_xmit+0x90/0x288 [
107.559431] [c14cd710] [c05c5784] __dev_queue_xmit+0x8c8/0xbec [
107.565247] [c14cd7c0] [c07cc83c] dsa_user_xmit+0x118/0x210 [
107.570810] [c14cd7e0] [c05c4d40] dev_hard_start_xmit+0x150/0x1ac [
107.576885] [c14cd820] [c05c5230] __dev_queue_xmit+0x374/0xbec [
107.582708] [c14cd8d0] [c07799b0] br_dev_queue_push_xmit+0x74/0x1f0 [
107.588972] [c14cd910] [c0779b80] br_forward_finish+0x54/0xe4 [
107.594709] [c14cd950] [c0775a64] br_dev_xmit+0x3dc/0x4d0 [
107.600100] [c14cd9a0] [c05c4d40] dev_hard_start_xmit+0x150/0x1ac [
107.606174] [c14cd9e0] [c05c5230] __dev_queue_xmit+0x374/0xbec [
107.611989] [c14cda90] [c070b0cc] ip6_finish_output+0x1f0/0x398 [
107.617907] [c14cdad0] [c070b2e8] ip6_output+0x74/0x1b4 [ 107.623126]
[c14cdb10] [c075da84] ip6_mr_output+0x88/0x460 [ 107.628612]
[c14cdbc0] [c070bb18] ip6_send_skb+0x34/0x140 [ 107.634003] [c14cdbe0]
[c073d560] rawv6_sendmsg+0xdc0/0x1124 [ 107.639654] [c14cdd20]
[c0591cd0] ____sys_sendmsg+0x1ec/0x2ac [ 107.645392] [c14cdd80]
[c05920c4] ___sys_sendmsg+0x80/0xd0 [ 107.650868] [c14cde80]
[c059403c] __sys_sendmsg+0x78/0x104 [ 107.656347] [c14cdef0]
[c000a498] system_call_exception+0x84/0x148 [ 107.662533] [c14cdf00]
[c000d0ac] ret_from_syscall+0x0/0x28 [ 107.668098] ---- interrupt: c00
at 0xb7bf6ef0 [ 107.672443] NIP: b7bf6ef0 LR: b7bdf3a8 CTR: 00000100 [
107.677482] REGS: c14cdf10 TRAP: 0c00 Tainted: G W O (6.18.31) [
107.684850] MSR: 0002d000 <CE,EE,PR,ME> CR: 20008802 XER: 00000000 [
107.691295] [ 107.691295] GPR00: 00000155 bf8538b0 b7c220c0 0000000e
bf853920 00000040 00000000 00000000 [ 107.691295] GPR08: 00000000
00000101 00000000 00000000 20008802 00000000 00a8e710 00000001 [
107.691295] GPR16: 00000000 bf853ab4 00000000 00000001 00000000
00000000 00a95ab4 00000020 [ 107.691295] GPR24: bf853b44 00000009
0000000e bf85393c 0000000e b7c1b050 b7c20b4c 00000155 [ 107.726114]
NIP [b7bf6ef0] 0xb7bf6ef0 [ 107.729770] LR [b7bdf3a8] 0xb7bdf3a8 [
107.733338] ---- interrupt: c00 [ 107.736466] Code: 5149a016 7f23cb78
1d290024 5785053e 39000000 38e00001 7c844a14 7fa6eb78 4bb454a9
813f06a4 57de1838 7d29f214 <90890004> 813f06a4 7d29f214 b3a90002 [
107.751165] ---[ end trace 0000000000000000 ]--- [ 107.755768] [
108.757295] Kernel panic - not syncing: Fatal exception [ 108.762507]
Rebooting in 3 seconds..

After this patch:

root@OpenWrt:~# echo plb:mcmal >
/sys/bus/platform/drivers/mcmal/unbind [ 149.334176] ------------[ cut
here ]------------ [ 149.338855] mal0: commac list is not empty on
remove! [ 149.344047] WARNING: CPU: 0 PID: 2375 at
mal_remove+0x44/0x94 [ 149.349805] Modules linked in: ath9k(O)
ath9k_common(O) nft_fib_inet nf_flow_table_inet ath9k_hw(O) ath(O)
nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir
nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash
nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct
nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mac80211(O)
cfg80211(O) spi_gpio spi_bitbang nfnetlink nf_reject_ipv6
nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 crc_ccitt
compat(O) ledtrig_usbport sha512 libsha512 sha256 sha1 seqiv drbg hmac
geniv cmac usb_storage leds_gpio dwc2 roles sd_mod scsi_mod
scsi_common gpio_button_hotplug(O) usbcore nls_base usb_common
crypto4xx crc32c_cryptoapi [ 149.412433] CPU: 0 UID: 0 PID: 2375 Comm:
ash Tainted: G O 6.18.34 #0 NONE [ 149.420845] Tainted: [O]=3DOOT_MODULE
[ 149.424323] Hardware name: Meraki MX60/MX60W Security Appliance
APM821XX 0x12c41c83 PowerPC 44x Platform [ 149.433760] NIP: c0555f20
LR: c0555f20 CTR: c04ad444 [ 149.438797] REGS: c149dcc0 TRAP: 0700
Tainted: G O (6.18.34) [ 149.446166] MSR: 00029000 <CE,EE,ME> CR:
48008242 XER: 20000000 [ 149.452343] [ 149.452343] GPR00: c0555f20
c149ddb0 c10666c0 00000029 3fffefff c149dc74 c149dc68 0000012b [
149.452343] GPR08: 00000027 c0a24b54 00000001 ffffefff 48008242
00000000 100737fc b7837fe4 [ 149.452343] GPR16: 00000002 b7837fe8
bfab3ef0 b7838230 00000000 b7838214 00000002 00000020 [ 149.452343]
GPR24: 10080000 00000000 c2065c70 c10f9610 c0a9c99c c0a9c99c c1102a00
c12b9a20 [ 149.487163] NIP [c0555f20] mal_remove+0x44/0x94 [
149.491681] LR [c0555f20] mal_remove+0x44/0x94 [ 149.496114] Call
Trace: [ 149.498551] [c149ddb0] [c0555f20] mal_remove+0x44/0x94
(unreliable) [ 149.504805] [c149ddd0] [c04c7f34]
device_release_driver_internal+0x1ec/0x28c [ 149.511839] [c149de00]
[c04c5108] unbind_store+0x70/0xc8 [ 149.517144] [c149de20] [c02a0cc0]
kernfs_fop_write_iter+0x18c/0x268 [ 149.523407] [c149de50] [c02096d0]
vfs_write+0x280/0x4a8 [ 149.528635] [c149dec0] [c0209ac0]
ksys_write+0x78/0x138 [ 149.533853] [c149def0] [c000a498]
system_call_exception+0x84/0x148 [ 149.540031] [c149df00] [c000d0ac]
ret_from_syscall+0x0/0x28 [ 149.545595] ---- interrupt: c00 at
0xb780500c [ 149.549940] NIP: b780500c LR: b77ecb80 CTR: b7804e60 [
149.554979] REGS: c149df10 TRAP: 0c00 Tainted: G O (6.18.34) [
149.562348] MSR: 0002f900 <CE,EE,PR,FP,ME> CR: 20002442 XER: 20000000
[ 149.569052] [ 149.569052] GPR00: 00000004 bfab3b50 b783f0d0 00000001
b7838da0 0000000a 00000000 00000000 [ 149.569052] GPR08: 00000000
00000000 b7832268 b7804e60 100096a8 00000000 100737fc b7837fe4 [
149.569052] GPR16: 00000002 b7837fe8 bfab3ef0 b7838230 00000000
b7838214 00000002 00000020 [ 149.569052] GPR24: 10080000 10080000
10080000 10080000 00000000 b7838060 b783db1c 00000004 [ 149.603872]
NIP [b780500c] 0xb780500c [ 149.607527] LR [b77ecb80] 0xb77ecb80 [
149.611095] ---- interrupt: c00 [ 149.614223] Code: 93e1001c 83e30050
7fe9fb78 85490150 7c0a4840 41820020 387f0030 48066865 809f0170
3c60c093 3863d120 4bad1fa9 <0fe00000> 7fe3fb78 4bffff01 807f0174 [
149.628919] ---[ end trace 0000000000000000 ]---

No more reboot.
> > +     }
> >
> >       mal_reset(mal);
> >
> > --
> > 2.54.0
> >
> >
>

