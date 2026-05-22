Return-Path: <netdev+bounces-290634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QSBeJ5mfD2p2OAYAu9opvQ
	(envelope-from <netdev+bounces-290634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:13:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640C5AD4C5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B5423005ABA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 00:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A94594A;
	Fri, 22 May 2026 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lx4gYGQs"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66A4086A;
	Fri, 22 May 2026 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408789; cv=none; b=PUggFEMX588NxNXucieOp8YRBjrQH9jxECCifWK+1J4FDXh/2YcmqbIoSykphpT6tk8JXo0ZtIdszPX5EG4wuKRJ6uidTnWIAC1E8FG5igt4hRpo1A/RdDX3MOhOgBKaRUeC+ITk9aMEcxFtc9TWBdUS3zsb6uCFYc5la5Qnl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408789; c=relaxed/simple;
	bh=Kfa2057Kkf7dohmMHqiefzbGx6Ns5jvJaPHn9r3aINw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c0yZRxbI7r0psIOHq3KY+F+Jl710g1VgdQuwROc9Jxa8KUHl9/zkIlZcu4ry0Zw9C1SuaHB1VB4y4eKVq2bcuMOXtYTcA6/9kRUu4LG6VxgUdGR5c/jPNzyYc61EX6ICVPmi0rMR3eWQAmexzdPqZSPtR4kS9ZSIPhHwgnJuAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lx4gYGQs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Date:Content-Type:
	References:In-Reply-To:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JCw8ieEkyKe+Xazv057M0WkKi++It7zZY5qDQVpILno=; b=lx4gYGQs9WLcD1bMh921uxOI1f
	A2+ax2rZX/ZzNQi1HAbFBiTsokJZnkRzMRQZt+ZE+8VH9wdmRTjuy68U6Huazk2xwO++V2yPRY741
	rzjojQbk+YB1vz4KzWoAdXAj/ISPrxU5iuyKehlksq1fn/3idKSJq6rNRJDy7vSmO1JNSgyHpCSeS
	pccyQEHP8g+EtQxwdT/6oxmcTYEVJF1tZT1AY9U7nFFr/ZR5DzoXlCl4vsKLjqlhwAiNoqUDnbfdk
	Gw5viOS5+fPN3LXwU7dUhREcmS1eSmH805BS+KhzpcEHha3nxvwwOGBzWEUDuAd7i+mI/4vjKGxv+
	zbf7isfA==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQDVZ-00000009EvJ-1MDF;
	Fri, 22 May 2026 00:12:57 +0000
Message-ID: <38ded3d61878f319ad74869924a55665d8baadb9.camel@infradead.org>
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
In-Reply-To: <87bje8v0xl.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	 <20260514225842.110706-4-hramamurthy@google.com>
	 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
	 <87tss0vdrj.ffs@tglx>
	 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
	 <87bje8v0xl.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-9xZVFjz8uf4IZdSVQ0VW"
Date: Fri, 22 May 2026 01:12:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290634-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 0640C5AD4C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-9xZVFjz8uf4IZdSVQ0VW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-22 at 00:43 +0200, Thomas Gleixner wrote:
> On Thu, May 21 2026 at 20:59, David Woodhouse wrote:
> > I didn't spent *that* long trying, but I couldn't see a way of doing it
> > centrally, which didn't end up making me sadder than the initial
> > duplication.
> >=20
> > Honestly, whether it was intent or omission, I suspect the approach
> > Harshitha took for GVE is the right one: Support TSC, and anyone who
> > uses KVM clock doesn't deserve accurate time anyway.
>=20
> I agree with the sentiment, but the implementation is just bonkers TBH.
>=20
> The driver should not even care about TSC/ARM_XX. Drivers have to be
> mostly agnostic of this and we went to a great length for that with the
> existing PTM core support. The core might need extensions for the pre/pos=
t
> muck, but that's not a justification for hacks like this GVE stuff.

I haven't looked hard at what GVE is trying to do; only glanced at the
consistency of CSID_X86_TSC vs. CSID_X86_KVM_CLK handling as I was
already sad about that one.

> >  <... migration...>
> Anything else is just crystal ball magic, which is what KVM has today....

Yeah, we digress. There's a 30-odd patch series on the kvm list to
clean up guest tsc/kvmclock handling and migration, and document the
process, if you want to come play. But honestly, there aren't enough
drugs in the world for someone to want to get involved in that crap
*voluntarily*. I recommend you don't ;)

> > So surely a device can only support this if it *does* have a precise
> > hardware timestamp, e.g. from ART? And the corresponding sys_realtime
> > and sys_monoraw fields also have to be from the *same* value, surely?
>=20
> That is correct, but you still fail to explain how this new made up
> att.counter_id/att.counter_value is filled in coherently without the
> driver doing something abysmal?
>
> You can't explain it, because the only way to do that correctly is by
> extending the cross time stamp struct and get_device_system_crosststamp()=
.

Yes. Isn't that what I asked Arthur to do?

> > Is that not how it works? If not.... WTF *is* it for?
>=20
> Yes, that's the way it works since get_device_system_crosststamp() got
> introduced, but that does not give a random driver access to the actual
> converted (TSC) counter value. The driver can only observe the PTM value
> which is ART on x86 and whatever on other architectures. So it does not
> know anything about it.

Sure, the driver can only return what it *knows*.

We're certainly missing some infrastructure here... maybe the pci_bus
should have a CSID which corresponds to its PTM domain, which on x86
would be CSID_X86_ART?=20

(I really do want to get my hands on one of those PTM-capable atomic
clock TimeCard things, and have a play with implementing vmclock on
them using ART as the reference)

> > We're allowed to set *fire* to anyone who just throws a random
> > get_cycles() call in there, aren't we? That's basically just self-
> > defence, m'lud.
>=20
> I agree, but the way how this attr.counter_id/value extension is defined
> either requires unholy hacks to get access to the ART/TSC conversion or
> resort to get_cycles().

Never get_cycles(). Let's perhaps make it *not* need unholy hacks to
interpret a PTM counter value. Otherwise what's the point in ART and
PTM at all?

> > > While this:
> ...=20
>=20
> > > +	xtstamp->sys_counter =3D system_counterval;
>=20
> ...
>=20
> simple core code change:
>=20
> > > Provides the information coherently and without any extra hacks. No?
> >=20
> > Yeah, that looks eminently reasonable. It isn't actually that far off
> > what Arthur did in patch 1 of the series, is it? He was adding other
> > clock quality attributes at the same time, and ended up shoe-horning
> > the cs_id and cycle_count into those instead of using a separate
> > system_counterval_t as you have here, which *is* cleaner. So yes, let's
> > get him to do that, but that part is cosmetic?
>=20
> No. It's not cosmetic.
>=20
> This patch #1 just defines new attributes, which include the CS ID and
> the CS counter value with absolutely ZERO explanation where these values
> are supposed to come from and ZERO explanation how they are coherent.

Pfft. Explanations are *definitely* cosmetic. And so is the difference
between a system_counterval_t, and a separate pair of {csid, cycles}
fields that precisely correspond to it; at least if we ignore use_nsecs
(which I have thus far).

I'll stand by calling that part cosmetic.

Not that we shouldn't fix it, but we should try to make our request of
the author clear and concise, and not catastrophise over the tweaks we
need to be made.
=20
> It suggests that the driver can fill them in along with the other truly
> driver related data, e.g. error_bound.
>=20
> But as I explained before the driver _cannot_ fill them in coherently
> neither for the new gettimexattrs64() nor for the getcrosststampattrs()
> callbacks.

And yet in patch 4/7, vmclock_populate_ptp_attributes() is *given* the
count value from which the time reading is generated, puts it into the
{csid, cycles} fields which we agree should be turned into a
system_counterval_t as part of the device timestamp, and I don't see
the problem.

> So you add an extension to the existing interface without core support,
> which means once that is merged the driver crowd will happily take any
> shortcut to support it.

Please be specific. Aside from the values being a system_counterval_t
in each timestamp (both pre/post and, for those devices which can, the
device time), what is missing?

> Are _you_ going to mop up the resulting mess?
>=20
> > > Extending get_device_system_crosststamp() for AUX clocks is on my tod=
o
> > > list for a long time, but I did not come around to it yet. It's not
> > > really complicated to make that work.
> > >=20
> > > The actual ena_phc_gettimexattrs64() implementation does not provide =
the
> > > counter value at all despite the fact that it could trivially do so w=
ith
> > > a modified ktime_get_snapshot() except for AUX clock IDs, but that's =
a
> > > solvable problem. See uncompiled PoC below.
> >=20
> > Huh? Unless it has PTM and is converting from ART (or is something
> > virtual like vmclock or the older non-LM-safe KVM hacks), surely the
> > driver has no business pretending to support 'precise' mode, and no
> > business providing a counter value?
>=20
> Huch?
>=20
> According to your earlier argumentation about counter values, you want
> the counter value, REALTIME, RAW combo even for gettimexattrs64() for
> the pre/post timestamps in case the hardware does not support PTM, no?

For the pre/post timestamps, sure. Not the *device* timestamp when it
doesn't support that.

> > In this case, we'd want the pre_ts and post_ts to be generated by the
> > common code using ktime_get_snapshot_id(cs_id) so that we have the
> > corresponding system_counterval_t in the 'A' parts of the ABA tuple...
> > but the device part of it can't pull one out of thin air unless it is
> > *part* of the device reading, surely?
>=20
> Correct, but where does the proposed patch set implement any of this?

It doesn't yet; I only asked for it this evening. Should be in the next
round.

> In the ena driver it sets cs_id and cs_value to 0,=C2=A0

Good. I hadn't looked hard at the ENA driver yet. So I asked Arthur if
he'd tried to expose a cycle value for the ENA PHC and the answer was
essentially "of course not; it doesn't have PTM".

> which will be replaced by abysmal hacks within no time because
> someone figures out that adding these values will give "better"
> results ....

Those were the ones we were allowed to set fire to, right?

> Neither the gettimexattrs64() nor the getcrosststampattrs() have any
> coherent way to fill in the CS related data, but you are pushing for
> adding this infrastructure first before thinking about the
> consequences. You can't be serious about that.

I do not believe I agree. I'm adding the infrastructure to report this
information because we *do* have it, and userspace wants to see it.

Some drivers *do* have it. The vmclock gettimex64 method literally just
calls ktime_get_snapshot(), populates both its pre and post timestamps
with the *same* result, and the device timestamp is calculated from the
same counter value at that precise moment.

It can *absolutely* also return the actual counter value used, if the
infrastructure supports that. As can the ptp_kvm drivers. And, a device
with PTM could report that too (although we do need a little more work
on cleanly converting that to an understandable domain, as you say).

And even for drivers which don't have simultaneous cycle readings,
userspace still wants to get the counter values corresponding to the
pre/post readings, which again can absolutely be supported.



--=-9xZVFjz8uf4IZdSVQ0VW
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMjAwMTI0
NFowLwYJKoZIhvcNAQkEMSIEIPlUla+Q+1UV9nuetByPwJH6+Oevx6AnvpQ1WL8VtvvKMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAbRldvc+kAGQ/
F4tL5s6gx9m3rqjIZ/edXZ1/lpzRPbIl0MAixmAv7wsourua1CfG3yd/DM7Q56bOq3Zzr2B6Y0Iu
o+cOdYQxjkKvpe/dnrpkvtsw33Wkck/xf2qqOcI5JKKYAZfNSfhQe9OySMUQMhCVzhIcm/qIDIfg
G+HGVBgYpI9M1reDWeK649tz21fEXM8yQZWWCRDrjUSXHIoEFMdsVa/EsopVcgs9zE6oSHhjTFoe
ilxrYN6gU4RgYIyHt0Xb8EeKqHwDqox/eVnwXDwMje1GLl7j32MomGmHQQiaQ5AQOLk3xk9PJrdV
/TMsujcSVCaLy+QA7XcCL/FhnRNLbvYu5EOJ/GOHQ2rltvdaZk6rxhFjyfPZXqNWddQZJIhUXaSm
Dp5POBCuehooG0u7xiedaar1scBo4vaolw5vIaXpyf7geX3LnOhjjO/5IHd+g4+7t9sLHdAHb3nn
f7t/3cdqYY/LIMU/KRvI0vHJEMdn7EVeM+29HpQ9c7na2HxgVujLKcCzwOsLx3U++r0w7oFhZfF+
Gnj/XGX2MV1rFfjDbVPthDCio8edPnlIdp/U3AJF1tZew+oKCeyrsVdWv++LEr/ovYZttoauSqxN
6gCyQhHvzJpsXiuXj1kDLzgIWT3iJkMSSM94dezVF9qcgkUZPz/usl8QayWjetUAAAAAAAA=


--=-9xZVFjz8uf4IZdSVQ0VW--

