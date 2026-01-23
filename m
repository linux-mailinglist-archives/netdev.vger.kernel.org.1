Return-Path: <netdev+bounces-252964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH8FJErXc2kOzAAAu9opvQ
	(envelope-from <netdev+bounces-252964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4E7A8DC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 750C23003BDF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D3248886;
	Fri, 23 Jan 2026 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hXlPRMs4"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459562C11C9;
	Fri, 23 Jan 2026 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199428; cv=none; b=OWsdyaQ4vhMrMQjjPyCHuA/U4XX4n78MuvZoXhZaRHGw3r0sa/vo8xiCK3xo9Og+Gfh7hZJx+SytMrfCcnl5535GXVsmwZgRHSNOtGyl1O98n3MVpEcEaUpLF39kCUjZzeCEEQMyaaB2rLrvZPTUDv9pMIc32FsdOx7hefaOyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199428; c=relaxed/simple;
	bh=W7fElqeXvLjGvdvBJvO01XNxYEd6W/KLt382xCvPQ8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVTHeFjqSKgByP+rC1nzaZJOuhoJ/RiF2y0C64Z6rlrFbJjWNcQb8MbTxB5bzJtapT3zAjaHcEJd7dRmNllgIBBoZdL9FeVl3wzZcT5ZtbcDkC4ToNejojrOQoGcQhnpO/ZEdEjWnzhnPUJD9fnxgTdKL6acDme/PiIenz9wZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hXlPRMs4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vt1C7y6WfqXnSCjXstGpvtK6IOkDXE5Bg5gDzC2JlvE=; b=hXlPRMs4+JZtF9Dkhw1zfsvIZw
	egaGFK7HZyIt2OYbK5u0h09vvG9TG8dbUXeQ5ZB8zyK+KDNqGhYa9Fff3fqLWdAGWWg2sUKmZV3Uu
	pJkyVasOQinQAxvJk7waqyjxlDnJoWM8SWmXLqv5LuROOaRikICpY2mjCKZ29Ez0HZf+QBMiSz8qY
	x7QwGqF85a4n9Y8B0AD5hwpdW8Iu/AyC0YO7wt6CamyOZT5b+GqZnypNzwtnkx67h7vWwea2/hp0e
	rAnxAGCU0qck+KBdL+NxcP1S0fyRU51suYdjLuM72UtB9atYji+OLKLlu6NejuOXV8BxUNciQDKYS
	4KQYMHDA==;
Received: from [2001:8b0:10b::4] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjNaQ-0000000300J-0KoM;
	Fri, 23 Jan 2026 20:16:58 +0000
Message-ID: <f663dbfff1568d8924a2a3b8fbd6532b97f54b68.camel@infradead.org>
Subject: Re: [v6,2/7] ptp: vmclock: support device notifications
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>, itazur@amazon.com
Cc: graf@amazon.de, itazur@amazon.co.uk, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, xmarcalx@amazon.co.uk,
 linux-kernel@vger.kernel.org,  edumazet@google.com, robh@kernel.org,
 richardcochran@gmail.com,  andrew+netdev@lunn.ch, mzxreary@0pointer.de,
 pabeni@redhat.com,  netdev@vger.kernel.org, krzk+dt@kernel.org,
 davem@davemloft.net, mail@bchalios.io
Date: Fri, 23 Jan 2026 12:16:46 -0800
In-Reply-To: <20260123031133.3059291-2-kuba@kernel.org>
References: <20260121143402.3092-3-itazur@amazon.com>
	 <20260123031133.3059291-2-kuba@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-N6jXm8iVxQHBPWb7ym/n"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[infradead.org:server fail,sin.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-252964-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.de,amazon.co.uk,kernel.org,vger.kernel.org,google.com,gmail.com,lunn.ch,0pointer.de,redhat.com,davemloft.net,bchalios.io];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C1B4E7A8DC
X-Rspamd-Action: no action


--=-N6jXm8iVxQHBPWb7ym/n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-22 at 19:11 -0800, Jakub Kicinski wrote:
>=20
> > +	status =3D acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTI=
FY,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 vmclock_acpi_notification_handler,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 dev);
>=20
> Since acpi_install_notify_handler() is called here, should there be a
> corresponding acpi_remove_notify_handler() in vmclock_remove()? Currently
> the handler remains registered after device removal, which could lead to
> a use-after-free if the hypervisor sends a notification after the driver
> state has been freed.
>=20
> [ ... ]
>=20
> > @@ -549,6 +653,11 @@ static int vmclock_probe(struct platform_device *p=
dev)
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		return ret;
> >=20
> > +	init_waitqueue_head(&st->disrupt_wait);
> > +	ret =3D vmclock_setup_notification(dev, st);
> > +	if (ret)
> > +		return ret;
>=20
> [ ... ]
>=20
> > @@ -581,6 +690,8 @@ static int vmclock_probe(struct platform_device *pd=
ev)
> > =C2=A0=C2=A0		return -ENODEV;
> > =C2=A0=C2=A0	}
> >=20
> > +	dev->driver_data =3D st;
>=20
> Is there a race window here? The ACPI notification handler is installed
> in vmclock_setup_notification() which runs earlier in vmclock_probe(),
> but the handler accesses device->driver_data. If the hypervisor sends a
> notification between vmclock_setup_notification() and this assignment,
> vmclock_acpi_notification_handler() would dereference NULL or garbage.
>=20
> I see this is fixed later in the series by commit 47fdd294385e which
> moves dev->driver_data =3D st before vmclock_setup_notification().

With the incremental diff below, I've fixed both of these in
https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/vmclock

Takahiro and Babis have the test environment set up to actually
exercise the notifications, so I'll let one of them actually do the
testing and repost v7.

Takahiro, please remember to add your own 'Signed-off-by:' as you do.

Thanks!


--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -490,17 +490,6 @@ static const struct file_operations vmclock_miscdev_fo=
ps =3D {
=20
 /* module operations */
=20
-static void vmclock_remove(void *data)
-{
-	struct vmclock_state *st =3D data;
-
-	if (st->ptp_clock)
-		ptp_clock_unregister(st->ptp_clock);
-
-	if (st->miscdev.minor !=3D MISC_DYNAMIC_MINOR)
-		misc_deregister(&st->miscdev);
-}
-
 #if IS_ENABLED(CONFIG_ACPI)
 static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void=
 *data)
 {
@@ -636,6 +625,32 @@ static int vmclock_setup_notification(struct device *d=
ev,
 	return vmclock_setup_of_notification(dev);
 }
=20
+static void vmclock_remove(void *data)
+{
+	struct device *dev =3D data;
+	struct vmclock_state *st =3D dev->driver_data;
+
+	if (!st) {
+		dev_err(dev, "vmclock_remove() called with NULL driver_data");
+		return;
+	}
+
+#if IS_ENABLED(CONFIG_ACPI)
+	if (has_acpi_companion(dev))
+		acpi_remove_notify_handler(ACPI_COMPANION(dev)->handle,
+					   ACPI_DEVICE_NOTIFY,
+					   vmclock_acpi_notification_handler);
+#endif
+
+	if (st->ptp_clock)
+		ptp_clock_unregister(st->ptp_clock);
+
+	if (st->miscdev.minor !=3D MISC_DYNAMIC_MINOR)
+		misc_deregister(&st->miscdev);
+
+	dev->driver_data =3D NULL;
+}
+
 static void vmclock_put_idx(void *data)
 {
 	struct vmclock_state *st =3D data;
@@ -701,12 +716,13 @@ static int vmclock_probe(struct platform_device *pdev=
)
=20
 	st->miscdev.minor =3D MISC_DYNAMIC_MINOR;
=20
-	ret =3D devm_add_action_or_reset(&pdev->dev, vmclock_remove, st);
+	init_waitqueue_head(&st->disrupt_wait);
+	dev->driver_data =3D st;
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, vmclock_remove, dev);
 	if (ret)
 		return ret;
=20
-	init_waitqueue_head(&st->disrupt_wait);
-	dev->driver_data =3D st;
 	ret =3D vmclock_setup_notification(dev, st);
 	if (ret)
 		return ret;



--=-N6jXm8iVxQHBPWb7ym/n
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDEyMzIwMTY0
NlowLwYJKoZIhvcNAQkEMSIEICxlH2W8Lhjbe5GOIH+4srWZNkuboyW8eDWlwsNV72AwMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAa/mQYKxAnONv
9Q2stfexZweLajR0094kKXL1mRa+rGM0MKAy/QyOo0/0bOcK+HH/+3jf1Xl9fgwsSv4swHIMLQFj
UVvwLULAqGWNZOddhTRWP+uWCQmT6g5IMlzhdykZR3LEZM0j9btMZ4d05o4+O90u5+u6s3BTKP0w
wF8o52aSguP3+A1NNBNajzp5GyfvxxVV709s1CIl1kCYyhhHkmL0LgBlK3M6VTAR7C+XbwTWO0Sz
XHiZvYlFSDkYYEfcyzXb+yqDHfyQ32/NoTqgkStbjLpUviI9/+IZ+xdye/WA+mULIEM2P9+it3jc
MXOz9JwJ21k0Bo2yvhiMaK1LTnrxEbmZiupArM36erEuRDhj8EFo2QChj9u8Ws33rzmS5QkrOwMr
CymwyN1R0Nf6w9Yjx/qy7XbRro/mOusk/S3IcFbwFoH+RnSOdTI5slop5u3+nuq2txZLUPUOApTK
g+3cr6CAQTY+hCkHXBzDCWLEetIjZIJtNfN7+rRB1zdHFda++YqMgIxfLuw0sFfZHO1ecqZLnml2
E0OddUi25Y/6k1mjNNAdLwS+FqwVvQzNMuNvFZ4Bw5L4xQJKkHX59RQqx0zd+iG+Psoc35NtJXXS
1HMICRTmZmre2fnWd8HgjPwdmJaNnkw+0jMutCT06glx2C25jfZxpqxA8zxfXIgAAAAAAAA=


--=-N6jXm8iVxQHBPWb7ym/n--

