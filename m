Return-Path: <netdev+bounces-290466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B95AAYVD2otFAYAu9opvQ
	(envelope-from <netdev+bounces-290466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19675A722A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1483D30BC196
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF72F90C9;
	Thu, 21 May 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VgqeQ/tH"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2D2E36F8;
	Thu, 21 May 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371425; cv=none; b=UDVWCM2qKAVg/ZqgF698GTJeUBdgyF2l1a8h4Z+TdxBZJ5jFy9/nZiJaMm+WS3QlfNnbOXFIwJa5DkfczISe75/S0FEc5u+j/OqTKsunJxOjl4Dk707HzhQEvXTvVCBKSO3Fe4cDXkveQT+dKicYe0dYnVg3ZdnldSOD+r7acj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371425; c=relaxed/simple;
	bh=/PYg3LzDwycufUxS/7KIN2HhHgzPI8EjxN8C+LTTOYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeVOMCA3MVZKNyDMygmea5B63i5MBd43x0wERbPsBs6UuKTcO7Iun36forY0akW/Q0t2ScUxmvMKR8zwbo4DuJGQzk83VYSsX8nYqOPBpeKK5zW+AstSrCwGXCaiclIHTgWLRBKEAyO7Quj0YIq1+7nMw+wZkNI9mRx08fL8cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VgqeQ/tH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0CM9IhQT+Y83uUQte91dt1kPsQeMtej9vqSox85j/I=; b=VgqeQ/tHZ3HrJhmFYVa2B0Cz7g
	G+Nourjfkav/411QKZ/Pf3OdyUeRb9B+2PDVxgo2GVkDshp/686AEEgHjnrTmpkvtKmBNQucQDd8X
	8CywwWfUF+jS2lVt+QHhL922/C5bUo0BmBrSCfj1VVrcGTDTBVlyzth2f6d0eiRZ6Y31a/051F0KQ
	057MoZ/mdaqCQnds+Zo4NRBlLTndvjSkeVUbRlropJ8i6V4bmtoqt+3dLPdKHkhP1DHX1r7cfLXLU
	dW8r4WQIZYI+neEJ0E/USz4W83SEsi21KLzbGbbLUgnL1XI4FhlVI9qct/OQAOkychyBcb8FUvvDj
	vaY8Lj6A==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3n2-00000008YDb-3Z21;
	Thu, 21 May 2026 13:50:21 +0000
Message-ID: <9503c90cbf50ba9d2e485a2a7b29e0aa3384c17c.camel@infradead.org>
Subject: Re: [PATCH v3 net-next 3/7] selftests/ptp: Add testptp support for
 attributes ioctls
From: David Woodhouse <dwmw2@infradead.org>
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, Yonatan
 Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, Alexander
 Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt
 Wilson <msw@amazon.com>,  Anthony Liguori <aliguori@amazon.com>, Nafea
 Bshara <nafea@amazon.com>, Evgeny Schmeilin <evgenys@amazon.com>,  Netanel
 Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Benjamin
 Herrenschmidt <benh@amazon.com>,  Noam Dagan <ndagan@amazon.com>, David
 Arinzon <darinzon@amazon.com>, Evgeny Ostrovsky <evostrov@amazon.com>, Ofir
 Tabachnik <ofirt@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, 
 vadim.fedorenko@linux.dev
Date: Thu, 21 May 2026 14:50:19 +0100
In-Reply-To: <20260515164033.6403-4-akiyano@amazon.com>
References: <20260515164033.6403-1-akiyano@amazon.com>
	 <20260515164033.6403-4-akiyano@amazon.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-kM5GRQPP2RTgZL9hAk4L"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org,kernel.org,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: A19675A722A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-kM5GRQPP2RTgZL9hAk4L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-15 at 16:40 +0000, Arthur Kiyanovski wrote:
> Add support for testing the new PTP_SYS_OFFSET_EXTENDED_ATTRS and
> PTP_SYS_OFFSET_PRECISE_ATTRS ioctls in the testptp utility.
>=20
> New command-line options:
> =C2=A0 -a: Get extended offset with attributes (error_bound, clock_status=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timescale)
> =C2=A0 -A: Get precise cross-timestamp with attributes
>=20
> These options allow testing and validation of PHC devices that provide
> clock quality information alongside timestamps.
>=20
> Also display the new clock_attrs capability in the -c output, and
> update print_system_timestamp to print unrecognized clock types instead
> of silently dropping them.
>=20
> Signed-off-by: Amit Bernstein <amitbern@amazon.com>
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>


...

> +			printf("extended timestamp request returned %d samples\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 getextendedattrs);
> +
> +			for (i =3D 0; i < getextendedattrs; i++) {
> +				print_system_timestamp(i, ext_clockid,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][0].pct.sec,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][0].pct.nsec,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "before");
> +
> +				printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 phc time: %lld.%09u, error bound: %u, clock status: %u, timescale: %=
u\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].pct.sec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].pct.nsec,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].att.error_bound,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].att.status,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].att.timescale);
> +
> +				if (soea->ts[i][1].att.counter_id)
> +					printf("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 counter: %llu (id: %u)\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long long)soea->ts[i=
][1].att.counter_value,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][1].att.counter_id)=
;
> +
> +				print_system_timestamp(i, ext_clockid,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][2].pct.sec,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soea->ts[i][2].pct.nsec,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "after");
> +			}
> +		}

Again I want to see the counter for the sandwiching values [0] and [2]
not just [1]. But other than that,

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

--=-kM5GRQPP2RTgZL9hAk4L
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMTEzNTAx
OVowLwYJKoZIhvcNAQkEMSIEIL3ow4wqAKoFILVITevWxq4RTB2SCCwAOGK4ohfuCaKRMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAMehisyd5l61o
dmh4yeg+6EpqeIYfVpWlaEQ6MXQWp0SUZzmYn15agkq93qfNinflrF4i7DW4kZvJvFbuG9fWF0RR
EFbctJrHjPOI1qEcDBcip3lln6v9q0pDqa1gu+4UfqpeFKV+b/chIoVgXJVe/x/ey0jHbhIglaM8
q7PzIUhWuMkaV9UJ2tw1xXcq7abp2NoSEZbGlKhafuTNj+ZMTrMp4K9MkVY7pOJZW1N3zx59jidi
3tmvHRYxcnBihyujdVRxo9GE+rFYorbX9gnwXFXXUtU6vSTKKocWwBggauL8H/4DQsXo5XZv1dtw
8lb278nre5Qf6b9+xiNBbNeFDQhW602l/iB+T1FNnv68p53eF4HrBSe6GKZx2riWgbfSZigDciob
/rOHYzveriCJ8TsjSprf/idG8u2bYb/YosShuLRWgoV7MEDu1NB843LpENWV0pK3rNoc0h44ehlA
t+cqlR6XmpjateUALHW2DH8ImDu47qUAOaBS8yJkl20CMtW+bFvl3V7RSbJPaPV717pNZcO0PoGn
6vQdcxi7f5Zai9JGdxJvRoPlsq/RaHS18QCZKT9aurSBYqiEP7rBNfq2s0Hmnr5alM5qpNKtKX97
XDMk03R5CwaJz1UFPRc5ALN+KQVmm8C5yeQ+9lzUtrUte2ax6ObbL7Wg3+h1tx4AAAAAAAA=


--=-kM5GRQPP2RTgZL9hAk4L--

