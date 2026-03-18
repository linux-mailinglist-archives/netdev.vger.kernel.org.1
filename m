Return-Path: <netdev+bounces-269079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OVhCvzJumkLcAIAu9opvQ
	(envelope-from <netdev+bounces-269079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:51:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 772692BEA37
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DCB630A4AC5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BB3BFE2F;
	Wed, 18 Mar 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FHdUyxQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3ED3D6684
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847600; cv=pass; b=bsuDfcHKH6g+5ih9KMnK3mY/5oBYcoT8yIGDqLY5VgIFuut3eC8wjjBHySV/hK6yrYvy5HxXacC6CvlTKhBjP+5Ck3XEt3BtuUmMyUCzfRxco1Ar4zf8jTZKFEgZi9qZKLvqR2BCXgSQgOtZtbJ3oiUqZ5u0SMX/mps6xwPN5w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847600; c=relaxed/simple;
	bh=QjOcEQWGs51K5ftSpknCetWaZNGTLDDCcVZG6h748kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOJI91RThdQiZe+LuWtJOKsdyN5LWuBzkpQ6N9Hm3xmLeRbLyYg86iRnggn3EbskrVttuoRNzrxbLhgMOX8Lpv7D6KTdOygPscycpthqv1BjEjhLgxmOgjHjTQl77atvR923eMJVzGtqlzexd+Lg0SoTWGtIBzA5Nw6Hm1VpdBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FHdUyxQX; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad8435f46so87685d50.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773847597; cv=none;
        d=google.com; s=arc-20240605;
        b=AnMjA5KIhPWBON/IcvwIMCYjWhf1iVUYyj9Op3jPTifAG1fJd47xxdaE1QeVjuTsdo
         ii7QpH7p2Tg7TpVbJa3/GrRcfEAYJKo2r9PecY6iObsRunPXVFN2CPcXG5m7/yivbOZU
         wKcIbkQcY16l24xAIOoLumzmghYlEUP47ThJ0AZzPXUjlz7kSOobXK5KN7vOM+noeTU0
         KuaIoBYZYBJ0eaeqZ92VvXz/gK9togCVJ2ULM2WDQjCTsMIBgzHW8jq1al2rirhIxUK2
         grTP9zppExknQoI0GovT4ip1sHMpDU5Cv7pjV4fyVO1U45CHkkcnxQPgR2iwjC29mXnh
         Z4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uf3s7lgvihAoxzh5Cm0Qtqo5La2QalQahjxJJTXHuPI=;
        fh=/5jqQHo0Mx/LlZ2y44HdMTn9VvnfkAM66XzzvgijR2k=;
        b=kO5J88J2BdVAxxZMao3KM6getaGKSWvHUkJbkRlaiA4Dr5QRRoMnRx2oGcsLXYmm5W
         KnXK8RuMYP/ROup3qzvYtCKdSszDPSA0el3KIg4O3eXHqA8S6Up+xDFUgVtVQDiR9iy0
         CSEwuAQAf8bNPavTvzOjHU3sQZDN2ZjslATMKvABgIAeW03FQUgJXqWxFiRQvnKvlPrF
         tTyGzPOIZxGxjB2YDOk6lM2iSt5lzecZXkK4mEcoquqQtXEuTey7Wnaw2xrihZFNlc6J
         07FaKl4dYCKHTZ/cdNHEfSZM+ScXAaio74ASMPwg5eZX8G4X4MPZUfcF1Ct847QeiqEj
         /uFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773847597; x=1774452397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uf3s7lgvihAoxzh5Cm0Qtqo5La2QalQahjxJJTXHuPI=;
        b=FHdUyxQX1KD0PgYMW+TrhAr3rZupsLXiZNqV8KK01cZeF3goBjVkYco2U7KuH+m1qt
         dFsuUiCewUODmF/fk8XQp3wbBC0Cd34janLCSJm1TTgEOP4dzUoZOHJeL4PqBnTNPPXU
         7DAqQfZ/RWR0YWq4hBZcEijqQSe6VH9oi4DLKeL/6E2ZYBP9n2UsWyATMSt1EOHiSBK4
         inFU+p9s35TLxCuNb547qo/4y8+ysn2/ysajQYXGzTXqbmfW4KrzrNTeD+419X5b+h4j
         enuQ0iuofKeNrRpiapJO+wACwEiJjOpzU3oHcLrV/2sy+ZSP6g+FSD/KHVxSYVzVr8My
         dkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847597; x=1774452397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf3s7lgvihAoxzh5Cm0Qtqo5La2QalQahjxJJTXHuPI=;
        b=OMJifvl4UE9EGQLZdYzzNjf9jFE95lmpJliuL57xFGGYqGvpQSWW7xGAPFY6onVgt7
         YWi7aHyGPKDnssHuS34FH8ErK5Yq6hWGJRDQ+BuNYneVTLuBDzxbWCzBHPAZG+rfNTiI
         X1cnis/CGkU/ehwAe8BDSk58shYrMrPiN3EfBrVi0rqjK7uWOR2eOpKfYMBOyJxw3kqy
         r8WE3BYx3KGGu76NMpirBPTnxEiSCeqlgQpd5NI8CQ9ugLPbVrgcS4AYdukkgeoIa898
         9M1lR3MOZkDQT8V5KQJNxrfiE9x9ppXJ4vwsy37B4bPjRCV2R7XHs7xiF4I4TPEdxzZy
         915A==
X-Forwarded-Encrypted: i=1; AJvYcCXt09uwDNFTmKjSXDpvMrPJP3YdqKzymwwogZEwjM4hJZGRLsPIsCokJx6OXrG0YrYI01D+Zm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9ZCMphIoUjy+JRlKBVWOFGPMjdMZ+316I1m8477rIF4KtdD6
	F2Sk3Th3CPARkeD2xYO2+5guXa20zgJXe3A10gFPsoxd5zsDGc8ngoCjWgbM4yo/m3AyCatHq1X
	cpDLSxhIv7keWZhlZhibySWWrpq0poYYaIvmUtN8rHAIKTWtOV2MpvgNI
X-Gm-Gg: ATEYQzz3IOI0rl1SM/oNBTZAoMx8r/fH0biFIvL5BclZZcuggzoiNxUgaEp9wwH62GP
	TRZmgKjzfI46O8bU0ac9zSGkynOH4EPdCHT5s7TLHPiXJPMK3uWczZ9sIgPapd27igpbNoNvtdk
	lemT6KRt94prqt9WwlH1edN32FJqJ94W4oslANkmGylaypu3f4/DKhNqkjrNXtGN7IEP8WlieCd
	Q5pJhr114066kf28DzD7v2FhGw9Ursuz/yLb8P9Jw16sKv2/vNZYG+JYmp6sV+fCuJClP/zFV7h
	T5X6G3zt4YOEs0SyRoIVJA==
X-Received: by 2002:a53:ecd7:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-64e9159edcfmr3048292d50.48.1773847596633; Wed, 18 Mar 2026
 08:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773759815.git.dcaratti@redhat.com> <7759f1fffdd0360e28687b660caaedba8ac6bed1.1773759815.git.dcaratti@redhat.com>
In-Reply-To: <7759f1fffdd0360e28687b660caaedba8ac6bed1.1773759815.git.dcaratti@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 18 Mar 2026 12:26:25 -0300
X-Gm-Features: AaiRm51dJoeTe7mfvwXtkeHWZK0j_7cUNzPz4ZSXBHP8j7s_nlWldKTeHpHNk74
Message-ID: <CA+NMeC-XtOcp_TrmKZ7DxLvdAXjsRciX3NLHhpuCCaGoNBpGtg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] tc-testing: add a test case for ETS offload
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e25615064d4e13c8"
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-269079-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 772692BEA37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e25615064d4e13c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:11=E2=80=AFPM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> While reviewing the fix for unintentional u32 overflows in ets offload
> code, Jamal said:
>
>  [...]
>
>  > otherwise a tdc test should cover it fine (when you get to the
>  > netdevsim change perhaps)
>
> Add a test case to reproduce the division by zero fixed in [1].
>
> [1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=3Di0xnoO2y=
iVB=3D-N4761mw@mail.gmail.com/
>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Sorry for not noticing this earlier.
I tried some approaches with Jamal to avoid changing your patch,
but changing it seems to be the cleanest way to do this.
The issue is that tdc overwrites the environment when running
the shell command from python so it can't find ethtool.
We believe the cleanest approach here is to specify
ethtool's path in tdc_config.py (as is done with tc and ip).
Am sending a proposed change as an attached diff in this
reply.

cheers,
Victor

--000000000000e25615064d4e13c8
Content-Type: text/x-patch; charset="US-ASCII"; name="ethtool_env_def.diff"
Content-Disposition: attachment; filename="ethtool_env_def.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mmw6sejw0>
X-Attachment-Id: f_mmw6sejw0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMtdGVzdHMv
cWRpc2NzL2V0cy5qc29uIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGMtdGVzdGluZy90Yy10
ZXN0cy9xZGlzY3MvZXRzLmpzb24KaW5kZXggNDc5Yjg2NjAzMWJiLi5lZTA5ZTZkNmZkZjMgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMtdGVzdHMvcWRp
c2NzL2V0cy5qc29uCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMt
dGVzdHMvcWRpc2NzL2V0cy5qc29uCkBAIC05OTcsNyArOTk3LDcgQEAKICAgICAgICAgfSwKICAg
ICAgICAgInNldHVwIjogWwogICAgICAgICAgICAgImVjaG8gXCIxIDEgNFwiID4gL3N5cy9idXMv
bmV0ZGV2c2ltL25ld19kZXZpY2UiLAotICAgICAgICAgICAgImV0aHRvb2wgLUsgJEVUSCBody10
Yy1vZmZsb2FkIG9uIgorICAgICAgICAgICAgIiRFVEhUT09MIC1LICRFVEggaHctdGMtb2ZmbG9h
ZCBvbiIKICAgICAgICAgXSwKICAgICAgICAgImNtZFVuZGVyVGVzdCI6ICIkVEMgcWRpc2MgYWRk
IGRldiAkRVRIIHJvb3QgZXRzIHF1YW50YSA0Mjk0OTY3Mjk0IDEgMSIsCiAgICAgICAgICJleHBF
eGl0Q29kZSI6ICIwIiwKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRl
c3RpbmcvdGRjLnB5IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGMtdGVzdGluZy90ZGMucHkK
aW5kZXggNGYyNTVjZWMwYzIyLi44MWI0YWMzZjA1MGMgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGRjLnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RjLXRlc3RpbmcvdGRjLnB5CkBAIC03NTUsNiArNzU1LDkgQEAgZGVmIGNoZWNrX2RlZmF1
bHRfc2V0dGluZ3MoYXJncywgcmVtYWluaW5nLCBwbSk6CiAgICAgICAgIE5BTUVTWydERVYyJ10g
PSBhcmdzLmRldmljZQogICAgIGlmICdUSU1FT1VUJyBub3QgaW4gTkFNRVM6CiAgICAgICAgIE5B
TUVTWydUSU1FT1VUJ10gPSBOb25lCisgICAgaWYgJ0VUSFRPT0wnIGluIE5BTUVTIGFuZCBub3Qg
b3MucGF0aC5pc2ZpbGUoTkFNRVNbJ0VUSFRPT0wnXSk6CisgICAgICAgIHByaW50KGYiVGhlIHNw
ZWNpZmllZCBldGh0b29sIHBhdGgge05BTUVTWydFVEhUT09MJ119IGRvZXMgbm90IGV4aXN0LiIp
CisgICAgICAgIGV4aXQoMSkKICAgICBpZiBub3Qgb3MucGF0aC5pc2ZpbGUoTkFNRVNbJ1RDJ10p
OgogICAgICAgICBwcmludCgiVGhlIHNwZWNpZmllZCB0YyBwYXRoICIgKyBOQU1FU1snVEMnXSAr
ICIgZG9lcyBub3QgZXhpc3QuIikKICAgICAgICAgZXhpdCgxKQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdGMtdGVzdGluZy90ZGNfY29uZmlnLnB5IGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdGMtdGVzdGluZy90ZGNfY29uZmlnLnB5CmluZGV4IGNjYjBmMDZlZjllMy4u
OTQ4OGIwM2NiYzJjIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0
aW5nL3RkY19jb25maWcucHkKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGMtdGVzdGlu
Zy90ZGNfY29uZmlnLnB5CkBAIC0xNyw2ICsxNyw3IEBAIE5BTUVTID0gewogICAgICAgICAgICdE
RVYxJzogJ3YwcDEnLAogICAgICAgICAgICdERVYyJzogJycsCiAgICAgICAgICAgJ0RVTU1ZJzog
J2R1bW15MScsCisgICAgICAgICAgJ0VUSFRPT0wnOiAnL3Vzci9zYmluL2V0aHRvb2wnLAogCSAg
J0VUSCc6ICdldGgwJywKICAgICAgICAgICAnQkFUQ0hfRklMRSc6ICcuL2JhdGNoLnR4dCcsCiAg
ICAgICAgICAgJ0JBVENIX0RJUic6ICd0bXAnLAo=
--000000000000e25615064d4e13c8--

