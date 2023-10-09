Return-Path: <netdev+bounces-39348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514E7BEE6A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4107281B48
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5E14AA0;
	Mon,  9 Oct 2023 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rwa4I42W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685511173D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:44:04 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F709A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:44:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a538026d1so267856276.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696891440; x=1697496240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcEkRtI6p90rXcCOvkouPghb3M9m0aVLP4AHp4xDips=;
        b=Rwa4I42WxiXXdptfUjSOUyqNZhDMOnOI1l+KC1YWHpvGJDOs3o17zdVc5WqhTsapfk
         ao99ZcqBhVR5+QVPTGcaozDvyDqEh6/C6nExnGFY7MsqUwj85VcrnAjJH6bqxqkqChTi
         OGEfpoPmbqez+38JL6xq9RUSrraHwKJ8Tjwjql/ODJt1/4k7SsCp15mL0vTJfjB+GSDZ
         x/1Lkklz3prHhrjlvsOU03vL9XpiMvnUbApv8zCyqIqwrtZWRECR7xQpRMN/FtCJauPL
         iZn3VqmxtIDxDbJ49LmpkiWZ/vpjWsQdbFETqwKWFpKZAKOm72JMTW8FXtg0j79iQUkw
         SD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891440; x=1697496240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcEkRtI6p90rXcCOvkouPghb3M9m0aVLP4AHp4xDips=;
        b=P80GT2zkLLtG60oQexXEYRXSBf+yzCTjdCG/wcuquvHygUO9ixsvpV9EaTit6Kl/SQ
         Rjc3tcGZU4Ulmpb6VFnNg9KPB1ectom//0LhmbWBcH5Fdjr4qA9MwxAVsiDRS8jo5AT3
         nLWJ3QnzeCjygPqpx77o0FxfpqhWskYMd+JwT2bSjfItV4fAOXhtMrW86yXNJNOTLbdA
         G6zM9ncyB/lHjfiZ8MaeYqrwlRHtCzM83xtY+nz5ERV0VMYap9CpsCkmvOhQexTsK5aL
         rAy3+AkmUl5NyaF+UdLL0OmC2oaw6Hwszf5/09frl0WWXy50XdY8Njw/XfTrSl5WixlD
         DgvQ==
X-Gm-Message-State: AOJu0Yz3WRNWigq+fnUQVkX0/EnZsn2MIj3ftnGUlKEdZQKq8f0Zro6D
	Fbf4VS1N4nhYASuyaz961s/0m63yJn0KIbmJDw==
X-Google-Smtp-Source: AGHT+IHkpV1hHXIfuxQJyt7g8E/CbFYu+6ckAULhpEVyGObpkH0MlWXRLpGSIDfzr9abk8U0Q+VRPJuFdqHSOOF6Ug==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c3:0:b0:d9a:45e7:b8bc with SMTP id
 186-20020a2500c3000000b00d9a45e7b8bcmr25189yba.4.1696891440537; Mon, 09 Oct
 2023 15:44:00 -0700 (PDT)
Date: Mon, 09 Oct 2023 22:43:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC6CJGUC/x3NTQrCQAxA4auUrA0krRb1KuJifqIG61iSoSild
 3dw+W3eW8HFVBzO3Qomi7q+SwPvOkiPUO6Cmpuhp35gohN6tZLmL2bTRcyxSMXsAU3CVOWJVqf jMB5eERPGyDTKPjFTglacTW76+d8u1237AVexKdp9AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696891439; l=1543;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=t6ppbaGIRSBsCeLAwhf3icSi3QggQapCJpuQhPkWhCk=; b=FWHhhun5aGED0QoILNdMciMZW3HTaYxCbuwQE2GB9YVe3/t5D443MOnBAm6QN6t6igpdopFpI
 UblLVj3B+mDBhtxxWYA5eMKhHFTTQGn4GjNgywTjOiej/yfypbDcEFq
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
	"=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 41ea3b5a42b1..d171c18dd354 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *ds, int port, u32 stringset
 
 	for (i = 0; i < RTL8365MB_MIB_END; i++) {
 		struct rtl8365mb_mib_counter *mib = &rtl8365mb_mib_counters[i];
-
-		strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", mib->name);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-bb106e4c110c

Best regards,
--
Justin Stitt <justinstitt@google.com>


