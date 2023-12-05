Return-Path: <netdev+bounces-53919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D218805343
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0237228143E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D356B66;
	Tue,  5 Dec 2023 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="ffSKPJX4";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="hrwT7yL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDE113
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KUpXeI6+0XNpV5kBDD0TXnF6iN8BwezthFLQZfMiPA0=; b=ffSKPJX4XDPifLITtT32+OIHHU
	6Eo4aA7rGPp5G4SV/n1DfLV6aSJDv5wagOhzchDLipYAUC7hWNtlDuPDNpEsJ6NlJ8Wc6K+zK8DO6
	4rLT139sLz8FJxYlx4k8OV3DXM/BuzRNCwwUHuv4dG1CXgMNa1CkSnUi0TCrd115ndocZpNH6hIMS
	NekH/IKelmBwWo6Fpe0paY3AlHV3fT6qdow8OSKHFKwrV7fAJBiGrQV2dUH9wutSzVyooWPanrH57
	AhNlYvwnQDBbAlhSCwKuG4L4vr0tufx3TpFLbwvZWHuYnz/3B7ICSUYe29y7PI1HZSc4nTc7ZpeDt
	tuYBVtEg==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:57022 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <dd@embedd.com>)
	id 1rATrJ-0003eD-0j;
	Tue, 05 Dec 2023 12:45:01 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, FRAUD_ATTACH 0.050000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MIME_TEXT_ONLY_MP_MIXED 0.050000, MSG_THREAD 0.000000,
	MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	RETURN_RECEIPT 0.500000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	__ANY_URI 0.000000, __ATTACHMENT_CD_FILENAMES 0.000000,
	__ATTACHMENT_NOT_IMG 0.000000, __ATTACHMENT_PHRASE 0.000000,
	__ATTACH_CTE_BASE64 0.000000, __ATTACH_CTE_QUOTED_PRINTABLE 0.000000,
	__BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
	__BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000,
	__CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CT 0.000000, __CTYPE_HAS_BOUNDARY 0.000000,
	__CTYPE_MULTIPART 0.000000, __CTYPE_MULTIPART_MIXED 0.000000,
	__DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
	__DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_ATTACHMENT 0.000000, __HAS_ATTACHMENT1 0.000000, __HAS_CC_HDR 0.000000,
	__HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_ATTACHMENT_1_N 0.000000, __MIME_ATTACHMENT_N_2 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_TEXT_P2 0.000000, __MIME_VERSION 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __NOTIFICATION_TO 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000, __TO_GMAIL 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_MAILTO 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 10%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.111515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=KUpXeI6+0XNpV5kBDD0TXnF6iN8BwezthFLQZfMiPA0=;
	b=hrwT7yL2kOkz3BmcGd4J2pM53QtamPOk+6svkHB11LdHIG8MgMkNl9E24lk/aOTDteFlJKjDL8ZP/rtmkQh4MNgyrH/+IhJdoOqKaa+tSDMaY/QK4w31iRF0UdqVR+YPkLdhsaasVCBmV0vdYYkkd2DJiwT23t5+wiVutv4dd2E=;
Message-ID: <db36974a7383bd30037ffda796338c7f4cdfffd7.camel@embedd.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
From: Daniel Danzberger <dd@embedd.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	 <f.fainelli@gmail.com>
Date: Tue, 05 Dec 2023 12:44:41 +0100
In-Reply-To: <20231205101257.nrlknmlv7sw7smtg@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
	 <20231205101257.nrlknmlv7sw7smtg@skbuf>
Disposition-Notification-To: dd@embedd.com
Content-Type: multipart/mixed; boundary="=-g56/lIXgWjfSdnrtXU4B"
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rATr1-0003Op-C0
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1rATr1-0003Op-C0; Tue, 05 Dec 2023 12:44:43 +0100

--=-g56/lIXgWjfSdnrtXU4B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-12-05 at 12:12 +0200, Vladimir Oltean wrote:
> On Mon, Dec 04, 2023 at 04:43:15PM +0100, Daniel Danzberger wrote:
> > Fixes a NULL pointer access when registering a switch device that has
> > not been defined via DTS.
> >=20
> > This might happen when the switch is used on a platform like x86 that
> > doesn't use DTS and instantiates devices in platform specific init code=
.
> >=20
> > Signed-off-by: Daniel Danzberger <dd@embedd.com>
> > ---
>=20
> I'm sorry, I just don't like the state in which your patch leaves the
> driver. Would you mind testing this attached patch instead?
Works fine. I could however only test the platform_data path, not the DTS p=
ath.

I would also move the 'enum ksz_chip_id' to the platform include, so instan=
tiating code can use the
enums to set ksz_platform_data.chip_id. (See attached patch)

--=20
Regards

Daniel Danzberger
embeDD GmbH, Alter Postplatz 2, CH-6370 Stans

--=-g56/lIXgWjfSdnrtXU4B
Content-Disposition: attachment;
	filename*0=0001-net-dsa-microchip-properly-support-platform_data-pro.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-net-dsa-microchip-properly-support-platform_data-pro.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA2MjE3OTI0YTAxMjdkMDczYWM3NTNjODYyYTYyYzc1MjMyMGFhMTUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgRGFuemJlcmdlciA8ZGRAZW1iZWRkLmNvbT4KRGF0
ZTogVHVlLCA1IERlYyAyMDIzIDEyOjA4OjE2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gbmV0OiBk
c2E6IG1pY3JvY2hpcDogcHJvcGVybHkgc3VwcG9ydCBwbGF0Zm9ybV9kYXRhIHByb2JpbmcKClRo
ZSBrc3ogZHJpdmVyIGhhcyBiaXRzIGFuZCBwaWVjZXMgb2YgcGxhdGZvcm1fZGF0YSBwcm9iaW5n
IHN1cHBvcnQsIGJ1dAppdCBkb2Vzbid0IHdvcmsuCgpUaGUgY29udmVudGlvbmFsIHRoaW5nIHRv
IGRvIGlzIHRvIGhhdmUgYW4gZW5jYXBzdWxhdGluZyBzdHJ1Y3R1cmUgZm9yCnN0cnVjdCBkc2Ff
Y2hpcF9kYXRhIHRoYXQgZ2V0cyBwdXQgaW50byBkZXYtPnBsYXRmb3JtX2RhdGEuIFRoaXMgZHJp
dmVyCmV4cGVjdHMgYSBzdHJ1Y3Qga3N6X3BsYXRmb3JtX2RhdGEsIGJ1dCB0aGF0IGRvZXNuJ3Qg
Y29udGFpbiBhIHN0cnVjdApkc2FfY2hpcF9kYXRhIGFzIGZpcnN0IGVsZW1lbnQsIHdoaWNoIHdp
bGwgb2J2aW91c2x5IG5vdCB3b3JrIHdpdGgKZHNhX3N3aXRjaF9wcm9iZSgpIC0+IGRzYV9zd2l0
Y2hfcGFyc2UoKS4KClBvaW50aW5nIGRldi0+cGxhdGZvcm1fZGF0YSB0byBhIHN0cnVjdCBkc2Ff
Y2hpcF9kYXRhIGRpcmVjdGx5IGlzIGluCnByaW5jaXBsZSBwb3NzaWJsZSwgYnV0IHRoYXQgZG9l
c24ndCB3b3JrIGVpdGhlci4gVGhlIGRyaXZlciBoYXMKa3N6X3N3aXRjaF9kZXRlY3QoKSB0byBy
ZWFkIHRoZSBkZXZpY2UgSUQgZnJvbSBoYXJkd2FyZSwgZm9sbG93ZWQgYnkKa3N6X2NoZWNrX2Rl
dmljZV9pZCgpIHRvIGNvbXBhcmUgaXQgYWdhaW5zdCBhIHByZWRldGVybWluZWQgZXhwZWN0ZWQK
dmFsdWUuIFRoaXMgcHJvdGVjdHMgYWdhaW5zdCBlYXJseSBlcnJvcnMgaW4gdGhlIFNQSS9JMkMg
Y29tbXVuaWNhdGlvbi4KV2l0aCBwbGF0Zm9ybV9kYXRhLCB0aGUgbWVjaGFuaXNtIGluIGtzel9j
aGVja19kZXZpY2VfaWQoKSBkb2Vzbid0IHdvcmsKYW5kIGV2ZW4gbGVhZHMgdG8gTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlcywgc2luY2Ugb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkKZG9lc24n
dCB3b3JrIGluIHRoYXQgcHJvYmUgcGF0aC4KClNvIG9idmlvdXNseSwgdGhlIHBsYXRmb3JtX2Rh
dGEgc3VwcG9ydCBpcyBhY3R1YWxseSBtaXNzaW5nLCBhbmQgdGhlCmV4aXN0aW5nIGhhbmRsaW5n
IG9mIHN0cnVjdCBrc3pfcGxhdGZvcm1fZGF0YSBpcyBib2d1cy4gQ29tcGxldGUgdGhlCnN1cHBv
cnQgYnkgYWRkaW5nIGEgc3RydWN0IGRzYV9jaGlwX2RhdGEgYXMgZmlyc3QgZWxlbWVudCwgYW5k
IGZpeGluZyB1cAprc3pfY2hlY2tfZGV2aWNlX2lkKCkgdG8gcGljayB1cCB0aGUgcGxhdGZvcm1f
ZGF0YSBpbnN0ZWFkIG9mIHRoZQp1bmF2YWlsYWJsZSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEo
KS4KClRoZSBlYXJseSBkZXYtPmNoaXBfaWQgYXNzaWdubWVudCBmcm9tIGtzel9zd2l0Y2hfcmVn
aXN0ZXIoKSBpcyBhbHNvCmJvZ3VzLCBiZWNhdXNlIGtzel9zd2l0Y2hfZGV0ZWN0KCkgc2V0cyBp
dCB0byBhbiBpbml0aWFsIHZhbHVlLiBTbwpyZW1vdmUgaXQuCgpBbHNvLCBrc3pfcGxhdGZvcm1f
ZGF0YSA6OiBlbmFibGVkX3BvcnRzIGlzbid0IHVzZWQgYW55d2hlcmUsIGRlbGV0ZSBpdC4KCi0t
LQogZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMgICAgICB8IDIxICsrKysr
KysrKysrKy0tLS0tLS0tCiBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uaCAg
ICAgIHwgMTkgKy0tLS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEv
bWljcm9jaGlwLWtzei5oIHwgMjIgKysrKysrKysrKysrKysrKysrKystCiAzIGZpbGVzIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jIGIvZHJpdmVycy9uZXQvZHNhL21pY3Jv
Y2hpcC9rc3pfY29tbW9uLmMKaW5kZXggZGM5ZWVhM2M4Li4yNDhkYzAzNGQgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jCisrKyBiL2RyaXZlcnMvbmV0
L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jCkBAIC0xNDU3LDE1ICsxNDU3LDIzIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qga3N6X2NoaXBfZGF0YSAqa3N6X2xvb2t1cF9pbmZvKHVuc2lnbmVkIGlu
dCBwcm9kX251bSkKIAogc3RhdGljIGludCBrc3pfY2hlY2tfZGV2aWNlX2lkKHN0cnVjdCBrc3pf
ZGV2aWNlICpkZXYpCiB7Ci0JY29uc3Qgc3RydWN0IGtzel9jaGlwX2RhdGEgKmR0X2NoaXBfZGF0
YTsKKwljb25zdCBzdHJ1Y3Qga3N6X2NoaXBfZGF0YSAqZXhwZWN0ZWRfY2hpcF9kYXRhOworCXUz
MiBleHBlY3RlZF9jaGlwX2lkOwogCi0JZHRfY2hpcF9kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRj
aF9kYXRhKGRldi0+ZGV2KTsKKwlpZiAoZGV2LT5wZGF0YSkgeworCQlleHBlY3RlZF9jaGlwX2lk
ID0gZGV2LT5wZGF0YS0+Y2hpcF9pZDsKKwkJZXhwZWN0ZWRfY2hpcF9kYXRhID0ga3N6X2xvb2t1
cF9pbmZvKGV4cGVjdGVkX2NoaXBfaWQpOworCQlpZiAoV0FSTl9PTighZXhwZWN0ZWRfY2hpcF9k
YXRhKSkKKwkJCXJldHVybiAtRU5PREVWOworCX0gZWxzZSB7CisJCWV4cGVjdGVkX2NoaXBfZGF0
YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYtPmRldik7CisJCWV4cGVjdGVkX2NoaXBf
aWQgPSBleHBlY3RlZF9jaGlwX2RhdGEtPmNoaXBfaWQ7CisJfQogCi0JLyogQ2hlY2sgZm9yIERl
dmljZSBUcmVlIGFuZCBDaGlwIElEICovCi0JaWYgKGR0X2NoaXBfZGF0YS0+Y2hpcF9pZCAhPSBk
ZXYtPmNoaXBfaWQpIHsKKwlpZiAoZXhwZWN0ZWRfY2hpcF9pZCAhPSBkZXYtPmNoaXBfaWQpIHsK
IAkJZGV2X2VycihkZXYtPmRldiwKIAkJCSJEZXZpY2UgdHJlZSBzcGVjaWZpZXMgY2hpcCAlcyBi
dXQgZm91bmQgJXMsIHBsZWFzZSBmaXggaXQhXG4iLAotCQkJZHRfY2hpcF9kYXRhLT5kZXZfbmFt
ZSwgZGV2LT5pbmZvLT5kZXZfbmFtZSk7CisJCQlleHBlY3RlZF9jaGlwX2RhdGEtPmRldl9uYW1l
LCBkZXYtPmluZm8tPmRldl9uYW1lKTsKIAkJcmV0dXJuIC1FTk9ERVY7CiAJfQogCkBAIC0yOTAw
LDkgKzI5MDgsNiBAQCBpbnQga3N6X3N3aXRjaF9yZWdpc3RlcihzdHJ1Y3Qga3N6X2RldmljZSAq
ZGV2KQogCWludCByZXQ7CiAJaW50IGk7CiAKLQlpZiAoZGV2LT5wZGF0YSkKLQkJZGV2LT5jaGlw
X2lkID0gZGV2LT5wZGF0YS0+Y2hpcF9pZDsKLQogCWRldi0+cmVzZXRfZ3BpbyA9IGRldm1fZ3Bp
b2RfZ2V0X29wdGlvbmFsKGRldi0+ZGV2LCAicmVzZXQiLAogCQkJCQkJICBHUElPRF9PVVRfTE9X
KTsKIAlpZiAoSVNfRVJSKGRldi0+cmVzZXRfZ3BpbykpCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uaCBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6X2NvbW1vbi5oCmluZGV4IGQxYjJkYjhlNi4uZmUxNTI1ZmZlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzel9jb21tb24uaAorKysgYi9kcml2ZXJzL25ldC9kc2Ev
bWljcm9jaGlwL2tzel9jb21tb24uaApAQCAtMTQsNiArMTQsNyBAQAogI2luY2x1ZGUgPGxpbnV4
L3JlZ21hcC5oPgogI2luY2x1ZGUgPG5ldC9kc2EuaD4KICNpbmNsdWRlIDxsaW51eC9pcnEuaD4K
KyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kYXRhL21pY3JvY2hpcC1rc3ouaD4KIAogI2RlZmlu
ZSBLU1pfTUFYX05VTV9QT1JUUyA4CiAKQEAgLTE2MiwyNCArMTYzLDYgQEAgZW51bSBrc3pfbW9k
ZWwgewogCUxBTjkzNzQsCiB9OwogCi1lbnVtIGtzel9jaGlwX2lkIHsKLQlLU1o4NTYzX0NISVBf
SUQgPSAweDg1NjMsCi0JS1NaODc5NV9DSElQX0lEID0gMHg4Nzk1LAotCUtTWjg3OTRfQ0hJUF9J
RCA9IDB4ODc5NCwKLQlLU1o4NzY1X0NISVBfSUQgPSAweDg3NjUsCi0JS1NaODgzMF9DSElQX0lE
ID0gMHg4ODMwLAotCUtTWjk0NzdfQ0hJUF9JRCA9IDB4MDA5NDc3MDAsCi0JS1NaOTg5Nl9DSElQ
X0lEID0gMHgwMDk4OTYwMCwKLQlLU1o5ODk3X0NISVBfSUQgPSAweDAwOTg5NzAwLAotCUtTWjk4
OTNfQ0hJUF9JRCA9IDB4MDA5ODkzMDAsCi0JS1NaOTU2N19DSElQX0lEID0gMHgwMDk1NjcwMCwK
LQlMQU45MzcwX0NISVBfSUQgPSAweDAwOTM3MDAwLAotCUxBTjkzNzFfQ0hJUF9JRCA9IDB4MDA5
MzcxMDAsCi0JTEFOOTM3Ml9DSElQX0lEID0gMHgwMDkzNzIwMCwKLQlMQU45MzczX0NISVBfSUQg
PSAweDAwOTM3MzAwLAotCUxBTjkzNzRfQ0hJUF9JRCA9IDB4MDA5Mzc0MDAsCi19OwotCiBlbnVt
IGtzel9yZWdzIHsKIAlSRUdfSU5EX0NUUkxfMCwKIAlSRUdfSU5EX0RBVEFfOCwKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9taWNyb2NoaXAta3N6LmggYi9pbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvbWljcm9jaGlwLWtzei5oCmluZGV4IGVhMWNjNmQ4Mi4uM2Yy
NGE3YTQ0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvbWljcm9jaGlw
LWtzei5oCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9taWNyb2NoaXAta3N6LmgK
QEAgLTIwLDEwICsyMCwzMCBAQAogI2RlZmluZSBfX01JQ1JPQ0hJUF9LU1pfSAogCiAjaW5jbHVk
ZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kYXRhL2RzYS5oPgor
CitlbnVtIGtzel9jaGlwX2lkIHsKKwlLU1o4NTYzX0NISVBfSUQgPSAweDg1NjMsCisJS1NaODc5
NV9DSElQX0lEID0gMHg4Nzk1LAorCUtTWjg3OTRfQ0hJUF9JRCA9IDB4ODc5NCwKKwlLU1o4NzY1
X0NISVBfSUQgPSAweDg3NjUsCisJS1NaODgzMF9DSElQX0lEID0gMHg4ODMwLAorCUtTWjk0Nzdf
Q0hJUF9JRCA9IDB4MDA5NDc3MDAsCisJS1NaOTg5Nl9DSElQX0lEID0gMHgwMDk4OTYwMCwKKwlL
U1o5ODk3X0NISVBfSUQgPSAweDAwOTg5NzAwLAorCUtTWjk4OTNfQ0hJUF9JRCA9IDB4MDA5ODkz
MDAsCisJS1NaOTU2N19DSElQX0lEID0gMHgwMDk1NjcwMCwKKwlMQU45MzcwX0NISVBfSUQgPSAw
eDAwOTM3MDAwLAorCUxBTjkzNzFfQ0hJUF9JRCA9IDB4MDA5MzcxMDAsCisJTEFOOTM3Ml9DSElQ
X0lEID0gMHgwMDkzNzIwMCwKKwlMQU45MzczX0NISVBfSUQgPSAweDAwOTM3MzAwLAorCUxBTjkz
NzRfQ0hJUF9JRCA9IDB4MDA5Mzc0MDAsCit9OwogCiBzdHJ1Y3Qga3N6X3BsYXRmb3JtX2RhdGEg
eworCS8qIE11c3QgYmUgZmlyc3Qgc3VjaCB0aGF0IGRzYV9yZWdpc3Rlcl9zd2l0Y2goKSBjYW4g
YWNjZXNzIGl0ICovCisJc3RydWN0IGRzYV9jaGlwX2RhdGEgY2Q7CiAJdTMyIGNoaXBfaWQ7Ci0J
dTE2IGVuYWJsZWRfcG9ydHM7CiB9OwogCiAjZW5kaWYKLS0gCjIuMzkuMgoK


--=-g56/lIXgWjfSdnrtXU4B--

