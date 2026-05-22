Return-Path: <netdev+bounces-290727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJcuA0kaEGoITgYAu9opvQ
	(envelope-from <netdev+bounces-290727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5E5B0C76
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69EC300DE25
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777963A6F15;
	Fri, 22 May 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/UDjgqG"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7921CFEF;
	Fri, 22 May 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440193; cv=none; b=e97tg5mAj+KyV8PjWwTzIY7j43wbJbVqAhv4uerxFxBUZgcIOCHKQtt7V4Kiuc9t0dKHTj/9jHWcxBMHTTw0d7o9NgvsWYvNHBSr/gGTxlJcLJe960TSSDeDIeEXyCd52p95IpEk5SWmlScbF9WREiLYj8Jut0vPgmxcFYXDOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440193; c=relaxed/simple;
	bh=iMdtUTSphcxgR5mPLnjkJdlXKt10gYyydi0/6WuYMRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcvY8iQnNzfqA/wqkvPQtr2u6O3cP7C0MCVM+Xd/offorbW/40SRuUGWfGiusdNYjwkQXSCciauzdMk5icbZOIw9tfHtVA32UtdPd+38cPYq9kNALSV4t71wIY8M55r1SlbzyMOY+xWwPInkrPE/d067zcxDlOMDD9cwKK2YlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n/UDjgqG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fGTXx8zDgCTxno519hVyftj+I8teyWEZh+n6fhFE/d4=; b=n/UDjgqGoLxObQKWirnW3pbpNZ
	Y7+BZJ0SyMdTROd1rlU5uSrUJuHWw5A0kvXLsSDhtpTlD9NvQGd4WsL6RsWiP35SJRzb6Heu7G/ZX
	1Yc2qy2lCZKeY75gevdojy0z6jMxtayDRA5vRL30IYC9ysDaFhEelsP3Bo+kFKIYojv1kSoesljM9
	4CJ4j1ueg2EL2GBg0W5fBjMADrlvbfISOoMPFDIm145kK8l+JJ+t3PHtr03B/fFOuFBmYJZPwewAy
	T9V/Qhqe/doyR6O7uql5P8obGo4KXZqTanlDpb6ypE/NMROphB9O6FPKnOxYX6mNorrYl1LtS8oq/
	LiSeqfTg==;
Received: from [172.31.31.148] (helo=u09cd745991455d.lumleys.internal)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQLg6-00000009qYh-3R6F;
	Fri, 22 May 2026 08:56:23 +0000
Message-ID: <0d13721307646d7ca2bf1aaf22926f0137b9de30.camel@infradead.org>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, Harshitha Ramamurthy
	 <hramamurthy@google.com>, netdev@vger.kernel.org, Arthur Kiyanovski
	 <akiyano@amazon.com>
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com,  jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com,  jfraker@google.com,
 ziweixiao@google.com, maolson@google.com,  jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com,  pkaligineedi@google.com,
 horms@kernel.org, jacob.e.keller@intel.com,  yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>
Date: Fri, 22 May 2026 09:56:22 +0100
In-Reply-To: <877bovvq78.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	 <20260514225842.110706-4-hramamurthy@google.com>
	 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
	 <87tss0vdrj.ffs@tglx>
	 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
	 <87bje8v0xl.ffs@tglx>
	 <38ded3d61878f319ad74869924a55665d8baadb9.camel@infradead.org>
	 <877bovvq78.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-PeXr9S2O7mQaPYdbm9/X"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FB5E5B0C76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-PeXr9S2O7mQaPYdbm9/X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-22 at 09:49 +0200, Thomas Gleixner wrote:
> On Fri, May 22 2026 at 01:12, David Woodhouse wrote:
> > On Fri, 2026-05-22 at 00:43 +0200, Thomas Gleixner wrote:
> > > > So surely a device can only support this if it *does* have a precis=
e
> > > > hardware timestamp, e.g. from ART? And the corresponding sys_realti=
me
> > > > and sys_monoraw fields also have to be from the *same* value, surel=
y?
> > >=20
> > > That is correct, but you still fail to explain how this new made up
> > > att.counter_id/att.counter_value is filled in coherently without the
> > > driver doing something abysmal?
> > >=20
> > > You can't explain it, because the only way to do that correctly is by
> > > extending the cross time stamp struct and get_device_system_crosststa=
mp().
> >=20
> > Yes. Isn't that what I asked Arthur to do?
>=20
> You maybe asked him, but I can't see any evidence of it anywhere. All I
> can see is a magic struct attr, which conveys CS related data that is
> supposed to be produced magically at some undefined place.

https://lore.kernel.org/all/8b8a748a2ac6e8e3d970f5e74a2774133e7e7d8c.camel@=
infradead.org/

> > > > Is that not how it works? If not.... WTF *is* it for?
> > >=20
> > > Yes, that's the way it works since get_device_system_crosststamp() go=
t
> > > introduced, but that does not give a random driver access to the actu=
al
> > > converted (TSC) counter value. The driver can only observe the PTM va=
lue
> > > which is ART on x86 and whatever on other architectures. So it does n=
ot
> > > know anything about it.
> >=20
> > Sure, the driver can only return what it *knows*.
> >=20
> > We're certainly missing some infrastructure here... maybe the pci_bus
> > should have a CSID which corresponds to its PTM domain, which on x86
> > would be CSID_X86_ART?
>=20
> Yes, that's correct. But that does not solve the underlying problem:
>=20
> ...
>
> Q: How is a driver supposed to fill in attr->cs_cycles coherently?
>=20
> A: Not at all.
>=20

Let me rephrase that to check my full understanding of it in context:

 Q: There are drivers today which operate on the TSC or arch counter,
    and they're just fine. But how is a future driver which uses PCIe
    PTM supposed to full in attr->cs_cycles coherently?

 A: Yeah, our PCI and platform code lack the proper arch-agnostic
    support for interpreting PTM time values; a driver wanting to do
    that is going to need to do some infrastructure work first to
    enable a proper conversion. But that's literally what PTM/ART is
    *for* so that work has to happen at some point anyway.


> The consequence of this is that the next driver writer will just go and
> do:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_id =3D IS_ENABLED(X86) ? CS=
ID_X86_TSC : CSID_ARM_COUNTER;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_cycles =3D get_cycles();
> =C2=A0=C2=A0 or
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->cs_cycles =3D ptm_cycles * pul=
ledout_of_thin_air_factor +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pu=
lledout_of_thin_air_offset;

Driver authors are crap, sure, but that would just be egregiously wrong
and hopefully it would be caught in review. It has to be a literally
*synchronous* capture or it's pointless.


> The same applies to the pre/post timestamp mechanism for
> gettimexattrs64().

There's literally a ptp helper to generate those, which can use
ktime_get_snapshot().

> These new attr IOCTLs are not restricted to your favorite vmclock PTP
> toy. They are available for every PTP driver which implements them, but
> there is no infrastructure to actually provide the required data. That
> ENA driver implementing gettimexattrs64() is demonstrating it. It at
> least does not try to make them up, but that's just a matter of time to
> happen.

The ENA driver demonstrates nothing of the sort. It's *not* filling in
those fields because it *doesn't* have PTM and it has nothing to fill
in.

Not *all* driver authors will fill in an optional field with random
bytes just because they *can*, Thomas.

> I know you don't care because that's outside of your sandpit,=C2=A0

Thomas, I'd like you to stop saying that. It's insulting, and it's wrong.

Of *course* I'm trying to solve things for the general case.

But that doesn't extend to implementing random parts of PCI and
platform infrastructure to allow for hypothetical future drivers which
want to use PTM to implement the optional fields we're adding today.

This yak is deep enough already :)

And although we're having this discussion *in* the GVE thread, I've
barely even *looked* at those patches and I think I'm still calling it
a 'hypothetical future driver', because obviously if it's trying to use
PTM then it's going to need that generic support.

> Are you going to monitor drivers/net/ for those instances and make
> sure they are burned before seeing the light of day?
>=20
> Surely not and neither is netdev going to care as demonstrated with
> this GEV mess.

I think that message has been received loud and clear, Thomas :)

> > Never get_cycles(). Let's perhaps make it *not* need unholy hacks to
> > interpret a PTM counter value. Otherwise what's the point in ART and
> > PTM at all?
>=20
> Perhaps? There is no perhaps and aside of that I gave you the solution
> for the problem already in the mail you just replied to, no?

Hm, did you? I'm sorry, I must have missed it. Even rereading it this
morning, I see a lot of 'is bonkers' and 'unholy hacks' and '_cannot_
fill them in coherently' but I can't see a concrete constructive
suggestion. You meant <87bje8v0xl.ffs@tglx>, yes?

Maybe it's lost in the noise. Let's try to simplify.

 =E2=80=A2 Userspace would like to be able to use PTP clocks to discipline =
the
   actual counter which is directly accessible in userspace and by KVM
   guests. Do do this, we only really need a system_counterval_t in
   the pre/post timestamps, and the helpers can add that.

 =E2=80=A2 *Some* drivers can actually provide a system_counterval_t in the
   device reading itself, either because they're naturally based on
   the CPU counter or because they have PTM. Drivers should report
   what=C2=A0they *do* know, in the correct time domain, and not make
   crap up.

 =E2=80=A2 Any driver which actually wants to do this based on PTM in the
   future will need to do the infrastructure work to make that work
   cleanly, and avoid having to make crap up.

And if I'm understanding correctly:

 =E2=80=A2 The GVE driver made crap up? Although they do so orthogonally to=
 the
   patch set we're *actually* talking about in this thread, because
   they did that entirely on their own *without* reference to Arthur's
   userspace API changes?


> I'm glad we agree on "Never get_cycles()" at least. May I ask you then
> to get a stiff drink ready and run:
>=20
> =C2=A0 # git blame drivers/ptp/ptp_vmclock.c | grep get_cycles

That's different because it's actually using it for the *device* timestamp.
But if you see an actual problem there, I'd love to know:

                /*
                 * When invoked for gettimex64(), fill in the pre/post syst=
em
                 * times. The simple case is when system time is based on t=
he
                 * same counter as st->cs_id, in which case all three times
                 * will be derived from the *same* counter value.
                 *
                 * If the system isn't using the same counter, then the val=
ue
                 * from ktime_get_snapshot() will still be used as pre_ts, =
and
                 * ptp_read_system_postts() is called to populate postts af=
ter
                 * calling get_cycles().
                 *
                 * The conversion to timespec64 happens further down, outsi=
de
                 * the seq_count loop.
                 */
                if (sts) {
                        ktime_get_snapshot(&systime_snapshot);
                        if (systime_snapshot.cs_id =3D=3D st->cs_id) {
                                cycle =3D systime_snapshot.cycles;
                        } else {
                                cycle =3D get_cycles();
                                ptp_read_system_postts(sts);
                        }
                } else {
                        cycle =3D get_cycles();
                }

                delta =3D cycle - le64_to_cpu(st->clk->counter_value);
                ...

--=-PeXr9S2O7mQaPYdbm9/X
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMjA4NTYy
MlowLwYJKoZIhvcNAQkEMSIEIKxvG6o1yb3qy7fMD1MhibvKO4vYiHdl5rFto48yCgRpMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAGN0aTw/e56cy
r1N3CLwfNZkAsKNN4+O1D7dNo7nzAvnYdpmjft+kfeFnYboRV2b8obNm+ZxqoVd3IrY4mmhXGpG8
04FSvJ6Iw/UY9EXVRQdpmlCs2S2MH6gB0T/aLN8WXX7u9S+QUS7q6T+KaAuFeeMQdPJcjpXbQKTG
IkkvVLTxjOAgTl9//OCPdDQDAqPG1v1f/mxRLWfsS5AZDkcRtCksTjuG+uJQ62Ixdsu9VbGDUuD9
YeKUdmkK1qBelTgQzL/BckDB+NxHTg8lrp0J4fNcmTyYidW2ikZ1n2ihJSCseCKscvoo0c/vb+YB
Ablp4TB/sIaYOAF5LRkpjObtWNxwJgl4IfHN+gSfhapfK/KI/iFOLioEN1q/FjlSrcXv9+xXhzsQ
VXveN1122xrGGOOGygd4JOD2i//8I9RzaecJOVmPDX068NismBjcXt5gw7tQXrR0glf427rV+zwR
udZs8Nlm6MDswCKt51Wq1s9N8/x6+soY4AsCcRa2/OdFvOlEN+2sdVP5/gv+oahUDvZjGq+VqNcs
QFBsxzINhmDRRea1ToVv8gtSwl84y3tnpWcSDZfQW0priAhlO/iTWPt9pHDSKc+fRFFIq/6zrIjz
MCtUoOniiSzFgwz9C/yiJGFuVkgw1DyMo6Lxr9Fk5BSEBTNddxftGYgJtFRxCbgAAAAAAAA=


--=-PeXr9S2O7mQaPYdbm9/X--

