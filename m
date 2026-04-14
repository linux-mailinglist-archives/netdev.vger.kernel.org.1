Return-Path: <netdev+bounces-278412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHWqCBEl3mmMoAkAu9opvQ
	(envelope-from <netdev+bounces-278412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1B3F95AC
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE32F3015319
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DEA3D9DA2;
	Tue, 14 Apr 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b="bipSc/Tp"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE57359A8D;
	Tue, 14 Apr 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.75.2.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166155; cv=none; b=rmjFsVh0Z3wv87eTB9KHLfhudTU8deL+3Lc4xRL5ZHC5A2XNidE0233vB6oNRyTQtT669HrWF09fi0LcKpYj/j+TEPbA7Ld09c/JJb/5VT8ihwAjVXNAyAel82SadQJTxpOMidh1O3FaBzgWlCRLIUw47icQUKJKbUHiLxRh8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166155; c=relaxed/simple;
	bh=aIvlOhVc3N1/VfSl72PbeaxfsGhW5PrhBZcZTFvOXyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqjZJvT5IJRXFzxrLd9vMRZdR2HR5z9bF17l9slW0DMruD6GXEQuHO2FEhLk/oksKlHOjuO1I3tCaa4Jvgri03fr/p8VO3q+tvsr82zWlh+0ZvgfN+0kDrQQ6E8zHSP84mtR9N4zcVIa7slSYrfUd+yYNaF2WkydhOlb5yB2UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de; spf=pass smtp.mailfrom=ikt.uni-hannover.de; dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b=bipSc/Tp; arc=none smtp.client-ip=130.75.2.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikt.uni-hannover.de
Received: from [172.23.180.109] (gateway.ikt.uni-hannover.de [130.75.73.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 5B0A3104;
	Tue, 14 Apr 2026 13:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-hannover.de;
	s=2024all; t=1776165814;
	bh=aIvlOhVc3N1/VfSl72PbeaxfsGhW5PrhBZcZTFvOXyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bipSc/TphMxvzeBxuQ+yhGj1hgqTGSz1EJHk5Wn+SVR1Cmmmcz4gH5//4B54iSFi3
	 iyV4lV9iTZy9+BlPzAmWYM42fXFZhclUGcuT7IJtUwVrfu6ft21999PK/MVM8cZ2v9
	 V+0Mr21ogJfZTDysMBKxrszDnw7PnifXVqxcIJu/wovpjrYY/FMo00cVpKYXbuUkqk
	 7DHCwtHkhg6SWvqJEkyp3JWZ7lwgwhCbF/nZiGb/0iMaTe7H7KtKHKdkFWA8SXDhhE
	 ZIrdHgwEFcNlDX5hjfp161NnDABrfTZfS3qDbKVmQPmKdo8xrc4I5a0Z7O3xf22mHm
	 Qoh1Lm4R4Q6zg==
Message-ID: <1bce4c38-3bc3-4d59-bf36-6aa47c7a5c77@ikt.uni-hannover.de>
Date: Tue, 14 Apr 2026 13:23:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH,net-next] tcp: Add TCP ROCCET congestion control
 module.
To: Neal Cardwell <ncardwell@google.com>, Tim Fuechsel <t.fuechsel@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <adIUY2N6HOKZNzSJ@volt-roccet-vm>
 <CADVnQymmsispHew4-frsuBBfObZHdSbH+jfP-9aSW1HguK_N4A@mail.gmail.com>
Content-Language: de-DE
From: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
In-Reply-To: <CADVnQymmsispHew4-frsuBBfObZHdSbH+jfP-9aSW1HguK_N4A@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms050900040809060206030106"
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uni-hannover.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[uni-hannover.de:s=2024all];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278412-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmx.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas.prause@ikt.uni-hannover.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uni-hannover.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arxiv.org:url,acm.org:url,ikt.uni-hannover.de:mid]
X-Rspamd-Queue-Id: 2BB1B3F95AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a cryptographically signed message in MIME format.

--------------ms050900040809060206030106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the very detailed review of our code.
We will incorporate your comments regarding documentation and variable
usage into a new version of our code.


> Please reference figures in the paper and mention specific concrete
> numerical examples of latency reductions to quantify these statements.

Figures 5 and 6 show the performance of ROCCET in stationary and mobile
scenarios (https://arxiv.org/pdf/2510.25281). In the analyzed scenario,
we have observed a lower sRTT with ROCCET than with BBRv3 and CUBIC. The
observed throughput was marginally lower than that of BBRv3, but still
on a similar level. A detailed quantitative evaluation can be found in
the paper in sections VI and VII.


> Can you please elaborate on this statement here? AFAICT from figures 7
> and 8 in https://arxiv.org/pdf/2510.25281 it seems ROCCET is
> essentially starved by CUBIC when sharing a bottleneck with CUBIC when
> the bottleneck has 2*BDP or more of buffering. AFAICT it sounds like
> ROCCET does have "fairness issues when sharing a link with TCP CUBIC"?

Our main use case is a connection where the bottleneck link is in the
cellular network, where the bottleneck queue is typically not shared
between flows. "Fairness" between flows is being implemented by the base
station's scheduler. In this scenario, ROCCET achieves its objective to
not "bloat" its own queue.

We have performed additional fairness experiments in non-cellular
networks (figures 7 and 8). Here we show that even when used in other
types of networks, ROCCET does not cause harm (see
https://dl.acm.org/doi/10.1145/3365609.3365855) to other congestion contr=
ol.


> Please specify what side effect or side effects ROCCET is claiming to
> solve (presumably bufferbloat?).
The side effect we observe in cellular networks is that, in particular,
for loss-based congestion control, the cwnd often gets 'frozen' at a
size that is too large for the BDP of the current link. This effect is
caused by the TCP cwnd validation, which at some point stops increasing
the cwnd because it assumes that the sender is application-limited.
However, this often leads to a cwnd size that is too large for the link,
but too small to cause a congestion event by overfilling the buffer. The
result is a standing queue that causes permanently high RTTs. Figure 2
in the paper (https://arxiv.org/pdf/2510.25281) shows the described
behaviour for a single TCP CUBIC flow.

> Expressed in isolation like this, that sounds potentially dangerous.
> Please mention what signal(s) ROCCET uses to exit slow start if it's
> not using loss.
>
> In addition, from reading the code AFAICT the connection does use loss
> to exit slow start (see my remarks below in this message). So AFAICT
> this summary seems inaccurate, or at least misleading?
You are right, the summary is misleading. In the code we submitted,
there are three conditions for exiting slow start:
The first one is packet loss (as you already mentioned, without a cwnd
reduction) Second is if the srRTT calculated by ROCCET exceeds an upper
bound and ACK rate, sampled in 100ms time intervals, differs by 10
segments. The third one is when the growth of the cwnd is stopped by the
TCP cwnd validation  (which considers the connection as
application-limited).


> If no lower RTT is found for 10 seconds, the algorithm interpolates
> the `min_rtt` upwards towards the current RTT.
>
> +  If the path is persistently congested (e.g., a large buffer is
> constantly full), the `min_rtt` baseline will drift up.
>
> +  This makes the algorithm less sensitive to queueing delay over
> time, potentially defeating the purpose of reducing bufferbloat in the
> long run. Contrast this with BBR, which actively drains the queue
> (using the ProbeRTT mechanism) to try to find the true physical
> minimum RTT.
>
> Can you please add a comment explaining why the ROCCET algorithm takes
> this approach, and how the algorithm expects to avoid queues that
> ratchet ever higher?
We added this functionality for the edge case of long-lived fat flows,
which are experiencing routing changes, to detect a higher base RTT.
Since this functionality is disabled by default and can also cause
problems with min_RTT detection, we have decided to remove it.
The measurement results in our paper have been obtained with this
functionality disabled.


> Here, `cnt` is incremented by `1` on every call, regardless of the
> `acked` value (number of packets ACKed in this event).
You are right, we will change this.


> +  With the default `ack_rate_diff_ca` of `200`, this condition will
> become true for $sum_cwnd * 100 / sum_acked >=3D 200$, i.e.
> $num_acks_per_round * 100 >=3D 200$. So AFAICT we expect this condition=

> to be true if there are 2 or more ACKs in a round trip. This makes
> `bw_limit_detect` effectively a no-op or always-on trigger rather than
> a true detector of queue growth or bandwidth limits.
The purpose of this part of the code was to detect an increasing queue
by monitoring data sent and acknowledged in combination with an
increasing sRTT over 5 RTT time intervals. In the steady state of a TCP
connection, the sending rate of the TCP sender should be equal to the
receiver's ack rate, due to TCP self-clocking. The idea behind this code
was to check if the cwnd is still correlated to the sending rate. If
this is not the case and we also observe increasing RTTs, we assume the
TCP sender is filling a buffer. However, we have made a mistake when
calculating sum_cwnd:
We are accumulating the cwnd on each ack event, instead of each RTT,
which, as you mentioned, would make more sense. Because this leads to
the erroneous behaviour that you described, we will remove this part of
the code for now until we have evaluated the intended implementation.


> Did the experiments in the paper use the approach documented in the
> paper, or the approach documented in this code? They are very
> different, AFAICT.
The experiments were performed using the submitted code. This means that
the mentioned code snippet always evaluates to true, so that ROCCET only
reacts to changes in latency, which is different from what we described
in the paper.


> Having a module parameter to ignore loss in this way makes it too easy
> for users to cause excessive congestion. I would urge you to remove
> that module parameter. Researchers can add that sort of mechanism in
> their own code for research.
That is true, we will remove this part of the implementation.

Thanks,
Lukas

--------------ms050900040809060206030106
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
DTswggZEMIIELKADAgECAhAV+a5sqo0u1NNveH8e3HsBMA0GCSqGSIb3DQEBCwUAMG8xCzAJ
BgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5z
dGl0dXRpb25zIENBMScwJQYDVQQDDB5IQVJJQ0EgQ2xpZW50IFJTQSBSb290IENBIDIwMjEw
HhcNMjUwMTAzMTExMzA4WhcNMzkxMjMxMTExMzA3WjBjMQswCQYDVQQGEwJHUjE3MDUGA1UE
CgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEbMBkG
A1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAxMIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKC
AYEAq7hur/5vIqMejblfPfZgGY75auSZz5SZ9x1dIIjvJrDBT0lIwQcAAoABJomkuv0kDK36
2UH+uf9JrOdLBjiKkEh99HQPmT+d1+Ijnnd1aAjiL+2Q4aU16P/snITYJL2ROU46zqmDkdoO
nCqMCEKSN74gHKDmApYfqXO8wmjmNA62wYHarp7lxgrBr0sk4BxHyKq52z0sWyxsdIy5V1K5
OOkCNwYupZ9b74LRhelYP5SieNDqU0S6IpQOasVz5IS0vDnqVi2ni67Gbgtb8dBKzH6gbAwG
ppHoeEFDcvJ042Oxtxt6BGolkUmguyfAgeisRqDjhQi+NfNgkDH81OLBV0eV07twS9axwNvJ
AtH2SgGiWKrYeuBgVCzs1DFT7sws1KHyLrOdZU0hJQSDfoz/8jwFmXhWoPvQQuWEoo3uvH6L
sHAo53aDF1aAUmGQ/JC72j7zZH16leJFuWj+t2TK/7YEVHtWluA9TOdx2Lz/SHh0/+pAVicD
4N/QUWPuBhzPAgMBAAGjggFmMIIBYjASBgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaA
FKDWBz1eJPd7oEQuJFINGaorBJGnMFAGCCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0
cDovL2NydC5oYXJpY2EuZ3IvSEFSSUNBLUNsaWVudC1Sb290LTIwMjEtUlNBLmNlcjBEBgNV
HSAEPTA7MDkGBFUdIAAwMTAvBggrBgEFBQcCARYjaHR0cDovL3JlcG8uaGFyaWNhLmdyL2Rv
Y3VtZW50cy9DUFMwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMEUGA1UdHwQ+MDww
OqA4oDaGNGh0dHA6Ly9jcmwuaGFyaWNhLmdyL0hBUklDQS1DbGllbnQtUm9vdC0yMDIxLVJT
QS5jcmwwHQYDVR0OBBYEFOuyLzv9rgLMKkQGXSXNHRIiaLBHMA4GA1UdDwEB/wQEAwIBhjAN
BgkqhkiG9w0BAQsFAAOCAgEAO964RfbcPCuTKAq2wXsOZxMaaLxITbSOYkt7RMxPw3CzU2qm
kTQALKbVqC1jUiNQWbkxZpsb8hy9FOHywH1xFmANAypks0Iuh+ovhqP90oFcfhvAfYxV2M0c
Gga9mTKFHP+QET7HW9pZdyWFZAw5fmdW9Ex+IQmJii0w/sozzwhpVn0OQYkkRV+2ydRa68JZ
S2NqAPpdaWoseM2X4u5+Jn+H2UO9paobX+ht91K2Ch8xzfREv4RLqBgpHBmkIDVygXNdXsKf
DHy2hOXxtF6oI1d7ErPGWoBxFc86aUqQlC6pEjb3ug24w+eg1kJj7IufHJ3iRm67Rdw5M1Ol
WMzxu+DwAKqFJhqes0OL/NOJOTuDCb0bIfVfjl8U0Y0QWCkhoCmNPZQQu6QM6Y/XxnALgRB4
drA8kip98wSZQmbqptE8oac2ZzLKCHiJlTdBuREsundnpBXdahMSrJ/mYv2pMZLpYkbrkvyh
orDVeH9t0a5UgPIFqGl8/ZzakJ3RQfr7HvdGur0YWU6KNWvY5BK8qHMRM0b3XtK9xREIGEyc
hAVReodDIhjrR4fWmjpa006r/UrmSk4bpKrVFVzTYsSK3jy4ri1ExVQp6RI6Ou4ZdbfwOYCu
I9wweMjpVBuqNzRKrVU/Pvp57gUzm4u+JJRkdioMOoxZrwsUiYr2KIojwTcwggbvMIIFV6AD
AgECAhBPXyBI3o2lCNUEcHAwcrzzMA0GCSqGSIb3DQEBCwUAMGMxCzAJBgNVBAYTAkdSMTcw
NQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25zIENB
MRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDEwHhcNMjUwNzAxMTEyODQ0WhcNMjcwNzAx
MTEyODQ0WjCB7TELMAkGA1UEBhMCREUxFjAUBgNVBAgMDU5pZWRlcnNhY2hzZW4xODA2BgNV
BAoML0dvdHRmcmllZCBXaWxoZWxtIExlaWJuaXogVW5pdmVyc2l0YWV0IEhhbm5vdmVyMREw
DwYDVQRhDAhHT1ZERStOSTEPMA0GA1UEBAwGUHJhdXNlMRcwFQYDVQQqDA5MdWthcyBKb2hh
bm5lczEeMBwGA1UEAwwVTHVrYXMgSm9oYW5uZXMgUHJhdXNlMS8wLQYJKoZIhvcNAQkBFiBs
dWthcy5wcmF1c2VAaWt0LnVuaS1oYW5ub3Zlci5kZTCCAiIwDQYJKoZIhvcNAQEBBQADggIP
ADCCAgoCggIBAMCey8Cfa8UVWdHPBu0eKmLN1vBp98X8mwtdWPoWASp77Ce8g8ta0f6y3XAY
6W8+gSrb0etZO/P5vxjus9CSVr9QQQr+AHLx9I2iuurzNoZ4Tq1NYLpfPbsI2xlXnTP7YJcx
kOo2x743dIAP3rkY5LJsccmU+Nw/Cdfmk0Nl1rFYvguj7rjkxVoB0wVnVCgiFeqMWhPVfN1m
iEElmkqZcf30z+lkq6yN7WKVPhw9Me8BBkr6uGJqa1QuQRS8sJswjFkXtIrHHdAuHwhHLm4U
cPYWQlWwY+sAa2CkT9cvMAxa24jHabaJjCTfAQ/cB/9qrBEbw82XWB6CX51gxoKe36AjHiL5
Xdz3eaFvZF/zmUR8OC58M2KObBrZwmBgmbAal0BpfU6EmB0+FaVO54iqb4gKOb9mHGa8Q4o5
qDJwumTaY+1ALd1sUu/XkGbLE6P9PcLXxA4DjjpUD93LALpG70e20POlYVGIo1/P8zA5GDlG
XLQhvdxZMOMS/c9AxtBxNy4QGlJETzHwQkLs9XK5PxyWUXvCYdnHXhHsFnaQi0OB45+3ve88
jI6ayFVUxvirAdwEJLmo0tqzkFL+G4dKmujaoeCnP/mV+Yam9PS1wC/E9tMMrgP+f6htKCzJ
a+R/jl7nuo9gB7b2vdgZa8luFPL9GifWK3QvEwycpZ5DPKZfAgMBAAGjggGSMIIBjjAfBgNV
HSMEGDAWgBTrsi87/a4CzCpEBl0lzR0SImiwRzBKBggrBgEFBQcBAQQ+MDwwOgYIKwYBBQUH
MAKGLmh0dHA6Ly9jcnQuaGFyaWNhLmdyL0hBUklDQS1HRUFOVC1TTUlNRS1SMS5jZXIwKwYD
VR0RBCQwIoEgbHVrYXMucHJhdXNlQGlrdC51bmktaGFubm92ZXIuZGUwYwYDVR0gBFwwWjAJ
BgdngQwBBQMCMAgGBgQAj3oBAzBDBg0rBgEEAYHPEQEBAgQCMDIwMAYIKwYBBQUHAgEWJGh0
dHBzOi8vcmVwby5oYXJpY2EuZ3IvZG9jdW1lbnRzL0NQUzAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC5oYXJpY2EuZ3IvSEFS
SUNBLUdFQU5ULVNNSU1FLVIxLmNybDAdBgNVHQ4EFgQUa+4u0KVjTBoRRNYzCyDqQHvvkGkw
DgYDVR0PAQH/BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4IBgQCNMzZAFmerRlElJ/YZ1KmKt3FB
QH37XjUYYDlmx8a+zw+THQI8uxBUBVFulpxD6eCZ9VT4hEznAV8CeAyg+FZ3m8gHUoMF7Ge9
tAej/iH1nHLXRt8SEnwwfpICAVPoZT32hf9gmu1sxlaxKPb+dO7e8eoQoFRTlWOIoYtf5+dN
1PXsLEcyQEx9RnJZeDjyZmN5HtcAxMzCzAm7otP+YLXCVi8OiQM2ytcCaBKKrtc1tYlrJpl+
8ot2YfbvAAF0TPc0Mj4xOZ1a4CtqAIOWmuKynK5jO4tbMEbN5S/+oFihm5as0MeeMVECLcT6
wHinSGM2ALMC2Vxw3nzL/7v1H+GxVlGM91bLRCCFxYPKr/lnVu6GqLHNZpWUVjXTw4pfANY4
HPBK7tDWqfrNVPKJlk0YFUK0M6i/5AFwgcHK1bv/4hwMi9VdXIXsB/OPeHa9D5t+/WkBqk3F
ZM/GjOWPhKUjVHdgByoq5M6qbxBNQLQWZg+jUa2KPshqEfwudiTA/IgxggWeMIIFmgIBATB3
MGMxCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFy
Y2ggSW5zdGl0dXRpb25zIENBMRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDECEE9fIEje
jaUI1QRwcDByvPMwDQYJYIZIAWUDBAIDBQCgggL4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQxNDExMjMzM1owTwYJKoZIhvcNAQkEMUIEQHC2j8Vb
mqtf1Cx+nxIHE4VQy2SK3GWwRBof5fGJOvLxkhvPWeMutV9XArhIuleaLBIA9srep9KKrAVl
F1FbK6gwgYYGCSsGAQQBgjcQBDF5MHcwYzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxl
bmljIEFjYWRlbWljIGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0ExGzAZBgNVBAMMEkdF
QU5UIFMvTUlNRSBSU0EgMQIQT18gSN6NpQjVBHBwMHK88zCBiAYLKoZIhvcNAQkQAgsxeaB3
MGMxCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFy
Y2ggSW5zdGl0dXRpb25zIENBMRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDECEE9fIEje
jaUI1QRwcDByvPMwggFXBgkqhkiG9w0BCQ8xggFIMIIBRDALBglghkgBZQMEASowCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA0GCCqGSIb3DQMCAgEFMA0GCCqGSIb3DQMCAgEFMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEFMAcGBSsOAwIaMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgIw
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCBDALBglghkgBZQMEAgcwCwYJYIZIAWUDBAIIMAsG
CWCGSAFlAwQCCTALBglghkgBZQMEAgowCwYJKoZIhvcNAQEBMAsGCSuBBRCGSD8AAjAIBgYr
gQQBCwAwCAYGK4EEAQsBMAgGBiuBBAELAjAIBgYrgQQBCwMwCwYJK4EFEIZIPwADMAgGBiuB
BAEOADAIBgYrgQQBDgEwCAYGK4EEAQ4CMAgGBiuBBAEOAzANBgkqhkiG9w0BAQEFAASCAgBo
SaCcCbn+7yWntXV5EY9YiLsJw3mY6Rjvx9uQdVKPGzaEVZYdsXlkIktxijjadoxPLlqBK42c
rTjOycjD+tgH1GVQUDWDjFSP3CcgTb85bAp3jjUphQPkGqn0RUny3QHb4v9OMoUsmYrHzUpx
IXmHuUkDEGSelp42Fq+x7zEcR3CvAJW58D8lsAb/7IJeg5ZJPlM5o74xDynfjITh+ddZo2YV
OjHOkdJO/P+sUFb0EpNmi5AXJW0lxdGDDo2rUiJabrP3XFO8jGJJ345kp9U2JJe8q7W9Q2Vw
7lzyiQC5+pIOzESDjZvqH4KPog+eee5CsWtHSeF2zppdlRITx271SMvBsHu1Dg5J69Y2UxIC
uBud3iCcTPU27UEiTvwh/byqMn99BmymhScPa2unxhi9pdiykq8N64zSQRlwttEGyDvFj/2m
GG9shzlJsTXz6rAgPYdw/nIrBkDcYTHOSVyZRtjEuvoFpQEWjoUod8G4fFrLiYdKKCA81Klz
l19srKbLlzc6wsz/n7OOcOnDKo2e2u5zeP8oOVWpESNrje04Fw/SyvMOvobLeuD9pZVaXVyW
Balt1NgW3u+wAnGQr3gq+byokYgZhsAaydKwrOvOlLyXx7gNQAXhdvtT3pLZAeS/zZVecIXO
wNofV9xb0waoF3zSEwWqq6MaUvIAnJyuBQAAAAAAAA==
--------------ms050900040809060206030106--

