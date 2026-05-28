Return-Path: <netdev+bounces-292742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNF6F0BfGGozjggAu9opvQ
	(envelope-from <netdev+bounces-292742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:29:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20D5F469D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43892300567C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381D421EF5;
	Thu, 28 May 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vulncheck.com header.i=@vulncheck.com header.b="kfGGJ8ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C840963D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981288; cv=pass; b=T5fv/S+9m/ra8yh11ERS02ww3aOt5M6wReLMAjjueKTuyJX+W7FVUEN65c3kue1lrkIc3p2BBDiylSkqiA6VQ9rafEIYlAk4Ms3Xfe1d1YaC9ZDGXo27bOiCCxEWTdeS3r4+gBlPZI2xYDV3/eFnOZFmvdbSR7HBMWY8qU+xmDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981288; c=relaxed/simple;
	bh=l/CKgWlA+vg5IAPpqIroDJRcRF1mleLhAdbpAV+UEtM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bZhEicfunzON9J0676imCsoriDwiTwjpKEF0epdlzZiTSSqzUkjQ7atjjL40sZ9U8A3YmZXASTAX9E0kR3PH4vDdBwNGqm6kn4OAZ3+dpc9ptWPXzWNpFDiJeDMx3rYE3M/FNoPdR9bkoOsjqrUgg2OnqThCL50mLbubkjRYFOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulncheck.com; spf=pass smtp.mailfrom=vulncheck.com; dkim=pass (2048-bit key) header.d=vulncheck.com header.i=@vulncheck.com header.b=kfGGJ8ql; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulncheck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vulncheck.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38be5e86918so21283281fa.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779981191; cv=none;
        d=google.com; s=arc-20240605;
        b=iWFBqDNlV2pMneURTBA6C2ThT6IWgSjyCgFiBGRoVFAJiUaRmX1ByiB6+QRCp4P7Tk
         095TtURJ2L1I4qnTFdakKns/YSYCK2SIZB2NzG3nVTwuI60h5I4Q+hCG684YZxhbUSO1
         zZ82r2bHeV97jDIzN+nHkiRIanAzyRlS49MmqL1Nlrw3Fal4Loy+6wX64h5OZCsCkuY6
         GcBbGwqMNLY12qrakfwzhHegVMReqcvifKPtf5ZhynbRDiG5GhnIZd4ifa25zwY+9vtA
         SJz2A9+7lvMP0xPgFsJ47P8FL+SYIJVRnnNetpmtc42tzoLF2AjE9ZSeaxehzyeEV48u
         v3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bh8wraRh5eHl7Shfl4xHfKLNX7u5E9Zv1qO3vvhrfkU=;
        fh=RK2a+nWb/f7rS9+23nOnOtLzejJkz20Uq+kKCAGiwfU=;
        b=Urom8kc7PgfCpYwu3rAW8WZUn0KJP91wAiABYwa6ntH5kimMs23yxmDSGSoXtkVvf4
         beCuw7EgspVA+4EFNxhyrrg4/XVaDSzdsEKO7j2WkaY8GavmRoPZYTsihm9CB8637MCk
         iH8AkPdBIz23XK3FXDXA8tr5+/7fvWhLkhG47+DZsXZFXo7HYvN454jEYYu0MVbSrbUZ
         rzEmxjva08DSRtk8BvskLusYuDdBxMK1gdsAfvqjJmWjBEfSYFyb4Y+IB/KQkEeA9w3r
         QoJqR57ZMxPRbJZnu5KQgE+v3AHAsPSng1+D75I4l5/6ILVHgrhUQfp+feG6GdARE22W
         ZRnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vulncheck.com; s=google; t=1779981191; x=1780585991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bh8wraRh5eHl7Shfl4xHfKLNX7u5E9Zv1qO3vvhrfkU=;
        b=kfGGJ8qlWbtLRf6Ah7mogYMddNYnY4DWgoysqNWplzfua3g2457Q9BEy8/TimNviwK
         QRNsJlPBnBuOD8nvDZWeEj18FiBxRDH3mslxko398INRUdgIqtqxCotfz+8ZPihPKh8A
         WEFRdRz5Kyd6jD7XJQXQ03OBNQT1+z6k5XRE4sfStel24QyfmUN3Gwkj47krOsBm1ex/
         y693+4TAx8wWCmPW3DTfg6sT447xROhJqZEpacxY61eAzUaj5Dpa2SeCdcgj8MhYSLyr
         t+tZ/NErJ6u/ut3ahPrn/qDthk9/x+CR0lIbQmosTpFoWniKvb9CEA3U9pSIO5fUm7Pf
         dauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981191; x=1780585991;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh8wraRh5eHl7Shfl4xHfKLNX7u5E9Zv1qO3vvhrfkU=;
        b=SQgqocs3VXbxpgkfHEZVR/1nENe1eWDcrBzbthNEpUTuMblHGnVlBbT3skcHWu/FMs
         oYBA0+YkukQFEOnvo3Z4UNiTTfzc1aEsC25AVBGm+v+8hlWGNgPa5eX2YHWkJPUs5CIZ
         3r0ZMK4VYzioMt7Q1lSwSO5lRBsbTgt9hEDLKKHEbUDDGRaiKoIqgTIrpx9BEnmcy85U
         Hro/ItZOSmmxNLGzZXXPiL9KqhAUXUzpkdv+l9QkAC45yI8aGW7z7j0Z6n1wS9tiXiUO
         gJLiYjZAmWFSQ6ifpDeTi/coE1XaomfSHBSdPQ8/NApKyuNu7Bh4SoYsPztUxNEHnrc8
         mwWA==
X-Gm-Message-State: AOJu0Ywwk/SPSFiuN/B5I+YDthhxw3wpC+QncnEQtZhfS7YhLogHh8y+
	w5iP/gxM3yCWQoQ1d8URHHigaIzWdVdu5GLVHZ7pal6sgEakOCj71X8xz4rOghle/NOacX8cda9
	5ubVCoB6xlRaZiemFik1txWQYekq7RxDWqwweiPOR+luAKNuS7cK64J0=
X-Gm-Gg: Acq92OEZGjEGpa4tsUxIJv84Y1rNTAQ/eHvwePRFUD3ma9WugvspOJy9LQU07g8mDan
	0xz44YBBXn3xx3PyXvEWprz4FjEDpV0J6liFZuXZtk5IvglaAvKIp6fin7n6DKwhduuI5ZYJ7Nn
	ht2WYvUq4sbdAicth8wSYUhjec+f97IXgN5xXMEh24xLk53uNmDXt6Hzyvup/rVcYOofUaiAd74
	6Q/DyMTLgRkM7nkl2+3k9mQTI4uQQMMEDiTzkZheLRf1OzfSXfB/mD8eNjK5edWOvlFO+UyQN4p
	lx0EPUEK6384ZLmXmMwIn3ZmDDCeYw6tJJ67iZWi1QETGAWo7i7/ZlS5QfAk
X-Received: by 2002:a05:651c:1512:b0:38c:e16a:439f with SMTP id
 38308e7fff4ca-395d8d91665mr87889121fa.23.1779981189338; Thu, 28 May 2026
 08:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wade Sparks <wsparks@vulncheck.com>
Date: Thu, 28 May 2026 11:12:32 -0400
X-Gm-Features: AVHnY4Is5MySF__qqDdErY-kvkZeDWpF1G8T_0F2lc-gWj7W1efIXtywxvnQslY
Message-ID: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
Subject: Unidentified Fragnesia Variant with Public PoC
To: netdev@vger.kernel.org
Cc: security@kernel.org, Disclosures <disclosure@vulncheck.com>
Content-Type: multipart/mixed; boundary="0000000000007f8bf60652e22a07"
X-Spamd-Result: default: False [3.44 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:url];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292742-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[vulncheck.com,reject];
	R_DKIM_ALLOW(0.00)[vulncheck.com:s=google];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.678];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsparks@vulncheck.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vulncheck.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ubuntu.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vulncheck.com:url,vulncheck.com:dkim]
X-Rspamd-Queue-Id: EA20D5F469D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007f8bf60652e22a07
Content-Type: multipart/alternative; boundary="0000000000007f8bf30652e22a05"

--0000000000007f8bf30652e22a05
Content-Type: text/plain; charset="UTF-8"

Hello netdev team,
(cc: security@kernel.org)

The VulnCheck Research team recently discovered and successfully reproduced
a *public* proof of concept
<https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc> (PoC)
published by V12 Security that targets an unidentified variant of
CVE-2026-46300, referred to as Fragnesia.

The original Fragnesia patch only addressed the coalesce path, leaving the
segmentation path independently exploitable. We confirmed the PoC works on
the latest Ubuntu kernel release <https://ubuntu.com/about/release-cycle>
as of 2026-05-27 (we are in the process of re-testing against v7.0.10 of
the kernel.org release <https://kernel.org/>). The variant is distinct
enough to warrant its own patch, as it operates in a different function
with a different trigger path that survives the existing fix.

If there is an existing patch that apparently has not made it's way to
Ubuntu distributions, we'd greatly appreciate if you could flag so that we
may initiate the CVE assignment process with kernel.org CNA.

We've attached our full technical report, and are here to answer any
questions.

Best regards,

<https://www.vulncheck.com/>

Wade Sparks III
VulnCheck
Senior Vulnerability Analyst

--0000000000007f8bf30652e22a05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello netdev team,</div></div><div>(cc: <a =
href=3D"mailto:security@kernel.org">security@kernel.org</a>)</div><div><br>=
</div><div>The VulnCheck Research team recently discovered and successfully=
 reproduced a=C2=A0<a href=3D"https://github.com/v12-security/pocs/tree/mai=
n/fragnesia-5db89c99566fc" target=3D"_blank"><b>public</b> proof of concept=
</a>=C2=A0(PoC) published by V12 Security that targets an unidentified vari=
ant of CVE-2026-46300, referred to as Fragnesia.</div><div><br></div><div>T=
he original Fragnesia patch only addressed the coalesce path, leaving the s=
egmentation path independently exploitable. We confirmed the PoC works on t=
he latest <a href=3D"https://ubuntu.com/about/release-cycle">Ubuntu kernel =
release</a> as of 2026-05-27 (we are in the process of re-testing against v=
7.0.10 of the <a href=3D"https://kernel.org/">kernel.org release</a>). The =
variant is distinct enough to warrant its own patch, as it operates in a di=
fferent function with a different trigger path that survives the existing f=
ix.</div><div><br></div><div>If there is an existing patch that apparently =
has not made it&#39;s way to Ubuntu distributions, we&#39;d greatly appreci=
ate if you could flag so that we may initiate the CVE assignment process wi=
th <a href=3D"http://kernel.org">kernel.org</a> CNA.</div><div><br></div><d=
iv>We&#39;ve attached our full technical report, and are here to answer any=
 questions.</div><div><br></div><div>Best regards,</div></div><div><br></di=
v><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature"><div dir=3D"ltr"><table style=3D"color:rgb(34,34,34);border:none;=
border-collapse:collapse"><tbody><tr><td style=3D"border-width:1pt;border-s=
tyle:solid;border-color:rgb(255,255,255);vertical-align:top;padding:5pt;ove=
rflow:hidden"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;vertical-align:baseline"><span =
style=3D"border:none;display:inline-block;overflow:hidden;width:49px;height=
:49px"><a href=3D"https://www.vulncheck.com/" style=3D"color:rgb(17,85,204)=
" target=3D"_blank"><img src=3D"https://lh7-us.googleusercontent.com/-9dCGn=
QIZaW0ehyK1B0bqLmef7d7ZWuSmmmWUYJGhzNgtzRhqFPZrtO3AnQt8PETFHiv6_YST3DacZVgr=
xPdAYXErAMnJrF6Isn27caszruLjby7jLRuuU__5emkqFjU8hczQ307--yVVMpVSiK7Qg" widt=
h=3D"49" height=3D"49" style=3D"margin-left:0px;margin-top:0px"></a></span>=
</span></p></td><td style=3D"border-width:1pt;border-style:solid;border-col=
or:rgb(255,255,255);vertical-align:top;padding:5pt;overflow:hidden"><p dir=
=3D"ltr" style=3D"color:rgb(32,33,36);line-height:1.2;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"color:rgba(0,0,0,0.847);font-family:-apple-syst=
em-font;font-size:12px">Wade Sparks III</span></p><div style=3D"color:rgba(=
0,0,0,0.847);font-family:-apple-system-font;font-size:12px">VulnCheck</div>=
<div style=3D"color:rgba(0,0,0,0.847);font-family:-apple-system-font;font-s=
ize:12px">Senior Vulnerability Analyst</div></td></tr></tbody></table></div=
></div></div></div>

--0000000000007f8bf30652e22a05--
--0000000000007f8bf60652e22a07
Content-Type: text/markdown; charset="UTF-8"; 
	name="Unpatched skb_segment() Fragnesia Variant with Public PoC.md"
Content-Disposition: attachment; 
	filename="Unpatched skb_segment() Fragnesia Variant with Public PoC.md"
Content-Transfer-Encoding: base64
Content-ID: <f_mppmlpax0>
X-Attachment-Id: f_mppmlpax0

IyMjIAoKIyMjIFVucGF0Y2hlZCBza2JcX3NlZ21lbnQoKSBGcmFnbmVzaWEgVmFyaWFudCB3aXRo
IFB1YmxpYyBQb0MKClYxMiBTZWN1cml0eSBbcHVibGlzaGVkIGEgUG9DXShodHRwczovL2dpdGh1
Yi5jb20vdjEyLXNlY3VyaXR5L3BvY3MvdHJlZS9tYWluL2ZyYWduZXNpYS01ZGI4OWM5OTU2NmZj
KSBvbiBHaXRIdWIgZm9yIGEgRnJhZ25lc2lhIChDVkUtMjAyNi00NjMwMCkgdmFyaWFudCB0aGF0
IGdldHMgdGhlIHNhbWUgcGFnZS1jYWNoZSB3cml0ZSB0aHJvdWdoIFxgc2tiXF9zZWdtZW50KClc
YCBpbnN0ZWFkIG9mIFxgc2tiXF90cnlcX2NvYWxlc2NlKClcYC4gVGhlIEZyYWduZXNpYSBwYXRj
aCAoXGBmODRlY2E1ODE3MzlcYCkgb25seSBmaXhlZCB0aGUgY29hbGVzY2UgcGF0aCDigJQgbm9i
b2R5IGF1ZGl0ZWQgc2VnbWVudGF0aW9uLiBUaGUgdmFyaWFudCBpcyB1bnBhdGNoZWQgaW4gbWFp
bmxpbmUgYXMgb2YgMjAyNi0wNS0xNSwgd2hpY2ggVjEyIFtub3RlcyBleHBsaWNpdGx5XShodHRw
czovL2dpdGh1Yi5jb20vdjEyLXNlY3VyaXR5L3BvY3MvdHJlZS9tYWluL2ZyYWduZXNpYS01ZGI4
OWM5OTU2NmZjKSBpbiB0aGVpciBwdWJsaWMgR2l0SHViIHdyaXRlLXVwLgoKVnVsbkNoZWNrIHJl
c2VhcmNoZXJzIHRlc3RlZCB0aGUgcHVibGljIFBvQyBvbiB0aGUgbGF0ZXN0IFVidW50dSB2ZXJz
aW9uIG9uIDIwMjYtMDUtMjcgYW5kIGRldGVybWluZWQgdGhlIFBvQyB3b3JrcywgdGhvdWdoIG5v
dGFibHkgaXQgaGFzIHRoZSBzYW1lIGNhdmVhdHMgYXMgdGhlIG9yaWdpbmFsIHZ1bG5lcmFiaWxp
dHkgKGkuZS4sIEFwcEFybW9yIHdvdWxkIHN0b3AgZXhwbG9pdGF0aW9uIG9uIGEgbW9kZXJuIHN5
c3RlbSkuIFRoaXMgdmFyaWFudCBhcHBlYXJzIHRvIHJlcXVpcmUgaXRzIG93biB1bmlxdWUgQ1ZF
IGFuZCBwYXRjaDogVGhlIHZ1bG5lcmFiaWxpdHkgaXMgaW4gYSBkaWZmZXJlbnQgZnVuY3Rpb24g
d2l0aCBhIGRpZmZlcmVudCB0cmlnZ2VyIHBhdGggdGhhdCBpbmRlcGVuZGVudGx5IHN1cnZpdmVz
IHRoZSBGcmFnbmVzaWEgcGF0Y2guIFxgc2tiXF9zZWdtZW50KClcYCBoYXMgdG8gcHJvcGFnYXRl
IFxgU0tCRkxcX1NIQVJFRFxfRlJBR1xgIGZyb20gZnJhZ1xfbGlzdCBtZW1iZXJzLCBub3QganVz
dCB0aGUgaGVhZC4KCiMjIyBWdWxuZXJhYmlsaXR5IERlY29uZmxpY3Rpb24KCkZyYWduZXNpYSdz
IGJ1ZyBpcyBpbiBcYHNrYlxfdHJ5XF9jb2FsZXNjZSgpXGAgd2hlbiBjb2FsZXNjaW5nIGZyYWdz
IGZyb20gYSBkb25vciBza2IsIHRoZSBcYFNLQkZMXF9TSEFSRURcX0ZSQUdcYCBmbGFnIGRvZXNu
J3QgZ2V0IGNvcGllZCBvdmVyLgoKVjEyJ3MgYnVnIGlzIGluIFxgc2tiXF9zZWdtZW50KClcYCDi
gJQgd2hlbiBidWlsZGluZyBHU08gc2VnbWVudHMgZnJvbSBhbiBza2IgdGhhdCBoYXMgYSBcYGZy
YWdcX2xpc3RcYCwgdGhlIGZsYWcgb25seSBnZXRzIHByb3BhZ2F0ZWQgZnJvbSB0aGUgaGVhZCBz
a2IuIElmIGEgZnJhZ1xfbGlzdCBtZW1iZXIgaXMgdGhlIG9uZSBjYXJyeWluZyBwYWdlLWNhY2hl
IGZyYWdzIChhbmQgdGh1cyB0aGUgZmxhZyksIGl0IGdldHMgc2lsZW50bHkgZHJvcHBlZCBkdXJp
bmcgc2VnbWVudGF0aW9uLgoKU2FtZSBmaWxlIChcYG5ldC9jb3JlL3NrYnVmZi5jXGApLCBzYW1l
IGZsYWcsIHNhbWUgb3ZlcnNpZ2h0IHBhdHRlcm4sIGRpZmZlcmVudCBmdW5jdGlvbi4KCiMjIyBW
MTIgU2VjdXJpdHkgUG9DIEFuYWx5c2lzCgpUaGUgVjEyIFNlY3VyaXR5IFBvQyBzZXRzIHVwIHRo
cmVlIG5hbWVzcGFjZXMgaW5zdGVhZCBvZiBvdXIgdHdvLiBUaGUgc2VuZGVyIGZpcmVzIFxgc2Vu
ZCgpXGAgXCsgXGBzcGxpY2UoKVxgIGJhY2stdG8tYmFjayBvbiB0aGUgc2FtZSBUQ1Agc29ja2V0
LiBHUk8gb24gdGhlIG1pZGRsZSAoZm9yd2FyZGluZykgbmFtZXNwYWNlIGNvYWxlc2NlcyBib3Ro
IGludG8gb25lIHNrYiB0aGUgc2VuZCBkYXRhIGJlY29tZXMgdGhlIGhlYWQgKG5vIHNoYXJlZC1m
cmFnIGZsYWcpLCB0aGUgc3BsaWNlIGRhdGEgZ29lcyBpbnRvIGZyYWdcX2xpc3QgKGZsYWcgc2V0
KS4gVGhleSBkaXNhYmxlIEdTTyBvbiB0aGUgZWdyZXNzIHZldGggc28gXGBza2JcX3NlZ21lbnQo
KVxgIHJ1bnMgYW5kIGJ1aWxkcyBmcmVzaCBzZWdtZW50IHNrYnMsIGNvcHlpbmcgdGhlIGZsYWcg
b25seSBmcm9tIGhlYWQuIFNlZ21lbnRzIGhpdCB0aGUgZXNwaW50Y3AgcmVjZWl2ZXIsIGluLXBs
YWNlIGRlY3J5cHQgZmlyZXMgb24gdGhlIHBhZ2UtY2FjaGUgcGFnZS4KCk1vcmUgbW92aW5nIHBh
cnRzIHRoYW4gdGhlIG9yaWdpbmFsIHRyaWdnZXIgKGV4dHJhIG5hbWVzcGFjZSwgR1JPIGNvYWxl
c2NpbmcgaGFzIHRvIGxhbmQsIEdTTy1vZmYgb24gdGhlIHJpZ2h0IGludGVyZmFjZSkgYnV0IHN0
aWxsIHJlbGlhYmxlOiBCYWNrLXRvLWJhY2sgc2VuZHMgY29hbGVzY2UgaW4gdGhlIHNhbWUgTkFQ
SSBwb2xsIGN5Y2xlIGFsbW9zdCBldmVyeSB0aW1lLCBhbmQgdGhleSByZXRyeSBvbiBtaXNzLgoK
T25jZSB0aGV5IGhhdmUgdGhlIHBhZ2UtY2FjaGUgd3JpdGUgcHJpbWl0aXZlLCB0aGUgcmVzdCBk
aXZlcmdlcyBmcm9tIHRoZSBvcmlnaW5hbCBhcHByb2FjaDoKClwtIFRoZXkgdGFyZ2V0IGEgU1VJ
RCBiaW5hcnkgKFxgc3VcYC9cYG1vdW50XGAvXGBwYXNzd2RcYC9cYGNoc2hcYCkgaW5zdGVhZCBv
ZiBcYC9ldGMvcGFzc3dkXGAgIApcLSBUaGV5IG92ZXJ3cml0ZSB0aGUgRUxGIHdpdGggYSAxMjAt
Ynl0ZSBcYHNldHVpZCgwKStleGVjdmUoIi9iaW4vc2giKVxgIHBheWxvYWQgIApcLSBUaGV5IHJ1
biB0aGUgY29ycnVwdGVkIFNVSUQgYmluYXJ5IHRvIGdldCByb290LCB2cyBvdXIgXGBzdSBcLVxg
IHdpdGggZW1wdHkgcGFzc3dvcmQgIApcLSBTYW1lIFxgZHJvcFxfY2FjaGVzXGAgY2xlYW51cCwg
c2FtZSB1c2VybnMgcmVxdWlyZW1lbnQKClRoZSB1bmRlcmx5aW5nIHByaW1pdGl2ZSBpcyBpZGVu
dGljYWwsIHRob3VnaDogQUVTLUdDTSBrZXlzdHJlYW0gWE9SLCBvbmUgYnl0ZSBwZXIgdHJpZ2dl
ci4gIAo=
--0000000000007f8bf60652e22a07--

