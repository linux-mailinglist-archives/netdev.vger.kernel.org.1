Return-Path: <netdev+bounces-292441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOyQHQVOF2r7AAgAu9opvQ
	(envelope-from <netdev+bounces-292441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD05E9DCE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8448030265DE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38573B19A5;
	Wed, 27 May 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dCCtwGMD"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E812D9481;
	Wed, 27 May 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912192; cv=none; b=XpecAp+bzckKStOD3qYmbX+/BhHEHAu7SCJqcQzEY7TGqlfDHUtMoC3C6jJBGC+xwP70W3Pp3Ov4By7XqyQVcNebD8E9f122Do1hGBh9RLuGRcmyFL23XQZ0cVCsRr9DfD4aaE5+KXNm/2nhnl5u01buS6/zAQFSTOGMxc3E2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912192; c=relaxed/simple;
	bh=l4mVcEG32W6Cc3FqCyTUr4O0Ae0WWM2RJ/6xKw7nwqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ei0UoRCVrU0++x2tmFVFVGeLk5V71Wkt8enjPmRoqDvkHJfS7w9rMsSMDPXIfo1KSND+05LO92vaVnYFYntGVEPJvNTmYheSKZwDltY1yXmJCNeXenRqKLLVzLnkifpbbt9+e/WB+ruNor1J1xiuy2TXTVZjq7XBYuvRXq/xdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dCCtwGMD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fvVAdiDUzqRlC/TYLD/F1friIG13PMnpdANXao0ov6Y=; b=dCCtwGMDN1F559pwP4dRALluHf
	AasXnjqn4D3kp4rWl9sPGADzb+qfP0fbDtGipYnN5TGNaAxO6EKbJ/wmWVms4mrkKJj9LMJXbu0ps
	USWkQ6cbhBa0wMF/5ySzOSU/yBxzaslZDbRkyDnW5UP+9iSd74Sm5T/qi6JvvtdMGIPEx8eCuuR/s
	FnmcayknYbUj0OCSyBT/J7YnX3OFaEs7vXZwpG4U4BBXcAnJefxmrvsYyhvLopI76vJhP+XDq61CC
	g9H/hJCPdkRtLms8nu29ZanY6vS1GLO417JoAaHX37HmEdMxsKuZcBQN8Y+d0TxDCX5ZaYfPSXgWQ
	Cn/Gt+Fg==;
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=lhr50-en-acc-sw5.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKT0-00000003JJl-38ld;
	Wed, 27 May 2026 20:03:03 +0000
Message-ID: <4322b8df98c08e238d4161bfacd46080c54f2c40.camel@infradead.org>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
From: David Woodhouse <dwmw2@infradead.org>
To: Jordan Rhee <jordanrhee@google.com>, Thomas Gleixner <tglx@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
 joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com,  jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com,  jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, thostet@google.com, 
 alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org, 
 jacob.e.keller@intel.com, yyd@google.com, jefrogers@google.com, 
 linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Date: Wed, 27 May 2026 21:03:01 +0100
In-Reply-To: <CA+mzVtt==6x0-BK7_5OupH+a=dwNrMY0YT4fGjHH2OM48MgLkA@mail.gmail.com>
References: <20260514225842.110706-1-hramamurthy@google.com>
	 <20260514225842.110706-4-hramamurthy@google.com> <87mrxtwzz9.ffs@tglx>
	 <CA+mzVtuhB9J9MDHSUfmBeV8hdtprGBsBZWrxLRtvdZY_V_NhNA@mail.gmail.com>
	 <CA+mzVtt==6x0-BK7_5OupH+a=dwNrMY0YT4fGjHH2OM48MgLkA@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-08Tdb1tbxYhteV/CSMX0"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73BD05E9DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-08Tdb1tbxYhteV/CSMX0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-27 at 11:46 -0700, Jordan Rhee wrote:
> Hello,
>=20
> We would like to request the community's guidance on how to proceed
> with adding
> cross-timestamp functionality to GVE. The key challenge is that the
> NIC clock can only be sampled in the hypervisor because the NIC time
> registers are only present on the PF, and a hypercall takes 60-80us.
> To minimize the uncertainty window, the hypervisor takes a TSC
> sandwich around the reading with an uncertainty window of ~1.2us,
> converts it to guest TSC, and returns it to the guest.
>=20
> The goals which led to this implementation were to minimize the
> uncertainty window and communicate the uncertainty window up the
> stack. I've reviewed
> https://lore.kernel.org/netdev/20260526165826.392227559@kernel.org/
> but I'm not sure how we would use it, so if it is intended to support
> our use case I would appreciate if someone could explain how we
> should use it.
>=20
> Here are some options on how to proceed, but other ideas are welcome.

So, your hypercall gives you the ABA timestamps of
PTP_SYS_OFFSET_EXTENDED where the 'A' timestamps are in the form of
guest TSC readings? It does not give you *simultaneous* capture and
thus you can not, and should attempt to, implement
PTP_SYS_OFFSET_PRECISE? Don't even think about that "midpoint" crap?

And your driver brackets the hypercalls with *actual* guest TSC reads,
to keep the hypervisor honest?

Based on Thomas's branch, I'd probably do something like:

 =E2=80=A2 ptp_read_system_prets()
 =E2=80=A2 Make the hypercall
 =E2=80=A2 ptp_read_system_postts()

Then do your sanity check that the guest TSC values provided by the
hypervisor are reasonable (inside the raw_cycles=C2=B9 values in the guest
pre/post snapshots). If not, return immediately using the wider
uncertainty window.

If you *do* believe the hypervisor-provided TSC readings, can't you
convert *each* of them to the system clock using
get_device_system_crosststamp(), a history from your captured prets,
and a get_time_fn callback that just creates xtstamp->sys_counter from
the hypervisor-provided TSC value for pre/post respectively, each time
you call it?

Take the code sample below with a *massive* pinch of salt; I only
shouted at the AI a few times when asking it to translate the
suggestion above into sample code, and I haven't gone over it with a
fine-tooth comb. But hopefully it helps enlighten what I'm
suggesting...

/*
 * Suggested approach for GVE PTP gettimex64 with hypervisor-provided
 * TSC values converted via get_device_system_crosststamp().
 *
 * This gives PTP_SYS_OFFSET_EXTENDED with ~1.2=C2=B5s uncertainty
 * (from the hypervisor's TSC sandwich) rather than ~60-80=C2=B5s
 * (from the guest-side hypercall latency).
 */

struct gve_xtstamp_ctx {
	u64 cycles;
};

static int gve_get_time_fn(ktime_t *device_time,
			   struct system_counterval_t *sys_counter,
			   void *_ctx)
{
	struct gve_xtstamp_ctx *ctx =3D _ctx;

	*device_time =3D 0;
	sys_counter->cycles =3D ctx->cycles;
	sys_counter->cs_id =3D CSID_X86_TSC;
	return 0;
}

static int gve_ptp_gettimex64(struct ptp_clock_info *info,
			      struct timespec64 *ts,
			      struct ptp_system_timestamp *sts)
{
	struct gve_ptp *ptp =3D container_of(info, struct gve_ptp, info);
	struct gve_sysclock_sample sysclock;
	u64 nic_ts;
	int err;

	mutex_lock(&ptp->nic_ts_read_lock);
	ptp_read_system_prets(sts);
	err =3D gve_ptp_read_timestamp(ptp, &sysclock);
	ptp_read_system_postts(sts);
	mutex_unlock(&ptp->nic_ts_read_lock);
	if (err)
		return err;

	nic_ts =3D sysclock.nic_timestamp;
	*ts =3D ns_to_timespec64(nic_ts);

	if (!sts)
		return 0;

	/*
	 * Sanity check: hypervisor-provided TSC values must fall
	 * within our guest-side bracket (using raw_cycles from the
	 * snapshots taken by ptp_read_system_prets/postts).
	 */
	if (sysclock.nic_pre_cycles >=3D sts->pre_sts.raw_cycles &&
	    sysclock.nic_post_cycles <=3D sts->post_sts.raw_cycles) {
		struct system_device_crosststamp xtstamp;
		struct gve_xtstamp_ctx ctx;

		/*
		 * Hypervisor values are trustworthy. Convert each TSC
		 * value to system time, narrowing the pre/post window
		 * from ~60-80=C2=B5s to ~1.2=C2=B5s.
		 */
		ctx.cycles =3D sysclock.nic_pre_cycles;
		err =3D get_device_system_crosststamp(gve_get_time_fn, &ctx,
						    &sts->pre_sts, &xtstamp);
		if (!err) {
			sts->pre_sts.sys =3D xtstamp.sys_realtime;
			sts->pre_sts.raw =3D xtstamp.sys_monoraw;
			sts->pre_sts.cycles =3D sysclock.nic_pre_cycles;
			sts->pre_sts.cs_id =3D CSID_X86_TSC;
		}

		ctx.cycles =3D sysclock.nic_post_cycles;
		err =3D get_device_system_crosststamp(gve_get_time_fn, &ctx,
						    &sts->pre_sts, &xtstamp);
		if (!err) {
			sts->post_sts.sys =3D xtstamp.sys_realtime;
			sts->post_sts.raw =3D xtstamp.sys_monoraw;
			sts->post_sts.cycles =3D sysclock.nic_post_cycles;
			sts->post_sts.cs_id =3D CSID_X86_TSC;
		}
	}
	/* else: keep the wider pre/post from ptp_read_system_prets/postts */

	return 0;
}

=C2=B9 https://lore.kernel.org/all/20260526230635.136914-1-dwmw2@infradead.=
org/

--=-08Tdb1tbxYhteV/CSMX0
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyNzIwMDMw
MVowLwYJKoZIhvcNAQkEMSIEIMRYP1z38/MF2hbX4ybsABbkcOmvNOffZNfD2yAMaVwYMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAJLEkVgnWEx2o
NeB/8VsA2NamIghxndJXx96kOqgkHhw+O+xuIRxF42AensV3p2N6LPQL0iOhmV60rEn8Ftnc/dI8
Xl0b+q/RovHyrbGzUXStQtbpkfm7bF6W3iCip12cU1XM1hRBO9NGruFwTB/eRZRiIGebwy/8cRKj
M+7BOMeeAkml0Cq735VNzGkCLRoLiy4nQhcKpTwCDtQfmF6jupLsH/UFmjmYk73BQPPAsmD1WrH/
JL+5GBYFGjaNo+QP7e0AVLr1IBi7Yi3b79Klv3Gr1XRJrOD/uBgsS/mtqMJlDTEbQtRrxsRvpFPd
ATNQjYCBILPuOY1+Q/V1wLXi7fszy5jt7bkovduBakE/4jCO21NO3pj1jrjGFuGTUqfcRDD01hCO
l1JZPNSuxnEKni4dk7vfj1+d5f2ZYVKY6LQNyHcfTmL0PdiqEIofLyIsoFjy8nIVmLMsMrv8mgof
AKG00gbhUYydYG5CPeGoyMntXPIKw7+8tKahhkqT4ww9YRpYLYPqvyaO8iKtC0ZjSEtGbNTtBQlB
5uzDq3rTGpmwY5ZC7H+EtmwOCJr5iFTDLj9Jf5dn86pWF5ejxpRUManzXhD/tvtRbVofix5esuzk
uCiFk++haq8SJbrsBvlPrDphuCo29p16Zxr4WgCD9Qw4uhu5H/p7HpLm+14WwsEAAAAAAAA=


--=-08Tdb1tbxYhteV/CSMX0--

