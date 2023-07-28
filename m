Return-Path: <netdev+bounces-22235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32562766A2E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9222825BA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822811C8E;
	Fri, 28 Jul 2023 10:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A1125A1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:23:30 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781FAE47
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:23:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991da766865so276680566b.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690539807; x=1691144607;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jwkGGL1MqdXYG7XAtFH7zvDkqIKJJdlPfuokfX9jHQ=;
        b=MWBYiJZX/JoGWa0HonD6OMRsNAtbSCC/yDjsTlY2Skx6LjqQ3ZAW0RUIssTbgzR5T/
         wC3xDT4gah9hkBTRPjl5xqH2TgRRI8+3Xf+d/dgVBOQ8plXk1MtyjUtGGRYqvYOsl6IZ
         cEi/SJ0F9j1Q0m+g2XpekBtpY7K7yuyFekIGlznZwMwVco+1czhIn1dxiOxos+/kJW/M
         byzQFLw6h2ULls3Ds8qbsWfVqyNG5M89O0DndOafvZqcpeE+l6+VY4VuCtgM7z/HTXaa
         HfqJR0WLPqIFUHoW5drsdIyZjkURKahi6TqIxeVMT0CQirUquhO0cvLvhfUEHFFfMMs7
         VTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539807; x=1691144607;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jwkGGL1MqdXYG7XAtFH7zvDkqIKJJdlPfuokfX9jHQ=;
        b=VuEpHtVY8p6324ZCK+ZxG09iIaMv7G5Mdojje2xQINIjFzTYSN6mZ4N2Tm++O1Tmj/
         OEsE8rSOWMfti4zdzuGd+oJoD+fRf0H3ozVG6XzPaGPl8dGIWIpyb587sUygz70z5xte
         uWjJGyX9rd0Jfv1nZpHOp2Vv2H1OCnfIR3pMjPIHcm+yIv2WZeXfyt9c3qI0jpIRfaKD
         OdKn0AI/NiWTAgyS9PPt85gynu/CsmTe9y0G7siJeBjFlMUA/+tDFd4JHtThoDva/+v/
         xqHXzT7FqSwbTS2wGDv5MMDq4hLe0wrK7EKZaVoRWeg6lwBtQ6ZaKsQG7IUpdMsm2HrO
         Iibg==
X-Gm-Message-State: ABy/qLbo+3eFE1oJhO6YYXjgQyAdh/gtUxfZBWZHD3tVPv/NlDI8XBWS
	OuDXuxphxScxKxcPvHZnlkNj8A==
X-Google-Smtp-Source: APBJJlFCpvr/9pMh7wlBubZ+oh6Ho/OTW49Cc7r+LPCvZwU+DYcZ2wDayvegaluzgTtHghJn0sKa6g==
X-Received: by 2002:a17:906:9bc2:b0:973:daa0:2f6 with SMTP id de2-20020a1709069bc200b00973daa002f6mr1598435ejc.3.1690539806789;
        Fri, 28 Jul 2023 03:23:26 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b00992025654c1sm1895488ejw.179.2023.07.28.03.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:23:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------06RGyS9oa7z67b6faIPYSIqs"
Message-ID: <5d240ea8-3fd9-5e43-1bcf-2923bfddee72@tessares.net>
Date: Fri, 28 Jul 2023 12:23:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink -
 manual merge
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------06RGyS9oa7z67b6faIPYSIqs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

On 26/07/2023 16:45, Russell King (Oracle) wrote:
> Older DSA drivers that do not provide an dsa_ops adjust_link method end
> up using phylink. Unfortunately, a recent phylink change that requires
> its supported_interfaces bitmap to be filled breaks these drivers
> because the bitmap remains empty.
> 
> Rather than fixing each driver individually, fix it in the core code so
> we have a sensible set of defaults.
> 
> Reported-by: Sergei Antonov <saproj@gmail.com>
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  9945c1fb03a3 ("net: dsa: fix older DSA drivers using phylink")

and this one from 'net-next':

  a88dd7538461 ("net: dsa: remove legacy_pre_march2020 detection")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, the two commits modify lines in the same
context but they don't modify the same ones. I then took the
modifications from both side.

Rerere cache is available in [2].

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/8cbf72d9be3a
[2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/b0f1
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------06RGyS9oa7z67b6faIPYSIqs
Content-Type: text/x-patch; charset=UTF-8;
 name="8cbf72d9be3a6a2cda95e3db9d1fa3cc4b5f3924.patch"
Content-Disposition: attachment;
 filename="8cbf72d9be3a6a2cda95e3db9d1fa3cc4b5f3924.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC9kc2EvcG9ydC5jCmluZGV4IGM2M2NiZmJlNjQ4OSwyZjYxOTVkN2I3
NDEuLjI0MDE1ZTExMjU1ZgotLS0gYS9uZXQvZHNhL3BvcnQuYworKysgYi9uZXQvZHNhL3Bv
cnQuYwpAQEAgLTE2ODYsOCAtMTcyMCwyMiArMTY4NiwxNSBAQEAgaW50IGRzYV9wb3J0X3Bo
eWxpbmtfY3JlYXRlKHN0cnVjdCBkc2FfCiAgCWlmIChlcnIpCiAgCQltb2RlID0gUEhZX0lO
VEVSRkFDRV9NT0RFX05BOwogIAotIAlpZiAoZHMtPm9wcy0+cGh5bGlua19nZXRfY2FwcykK
IC0JLyogUHJlc2VuY2Ugb2YgcGh5bGlua19tYWNfbGlua19zdGF0ZSBvciBwaHlsaW5rX21h
Y19hbl9yZXN0YXJ0IGlzCiAtCSAqIGFuIGluZGljYXRvciBvZiBhIGxlZ2FjeSBwaHlsaW5r
IGRyaXZlci4KIC0JICovCiAtCWlmIChkcy0+b3BzLT5waHlsaW5rX21hY19saW5rX3N0YXRl
IHx8CiAtCSAgICBkcy0+b3BzLT5waHlsaW5rX21hY19hbl9yZXN0YXJ0KQogLQkJZHAtPnBs
X2NvbmZpZy5sZWdhY3lfcHJlX21hcmNoMjAyMCA9IHRydWU7CiAtCisgCWlmIChkcy0+b3Bz
LT5waHlsaW5rX2dldF9jYXBzKSB7CiAgCQlkcy0+b3BzLT5waHlsaW5rX2dldF9jYXBzKGRz
LCBkcC0+aW5kZXgsICZkcC0+cGxfY29uZmlnKTsKKyAJfSBlbHNlIHsKKyAJCS8qIEZvciBs
ZWdhY3kgZHJpdmVycyAqLworIAkJX19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRF
Uk5BTCwKKyAJCQkgIGRwLT5wbF9jb25maWcuc3VwcG9ydGVkX2ludGVyZmFjZXMpOworIAkJ
X19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV9HTUlJLAorIAkJCSAgZHAtPnBsX2NvbmZp
Zy5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7CisgCX0KICAKICAJcGwgPSBwaHlsaW5rX2NyZWF0
ZSgmZHAtPnBsX2NvbmZpZywgb2ZfZndub2RlX2hhbmRsZShkcC0+ZG4pLAogIAkJCSAgICBt
b2RlLCAmZHNhX3BvcnRfcGh5bGlua19tYWNfb3BzKTsK

--------------06RGyS9oa7z67b6faIPYSIqs--

