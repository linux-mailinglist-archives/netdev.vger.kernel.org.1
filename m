Return-Path: <netdev+bounces-32748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081879A28D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 06:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CE11C2082F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5911FB8;
	Mon, 11 Sep 2023 04:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392B185D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 04:45:32 +0000 (UTC)
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744FC10F
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1694407529; x=1694666729;
	bh=i8Waf0l29DinGmqyd3hLSmAgjxNYR/djArNAz36tNBs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qO/hX2lk5NHvGXYbtApX0c2kH6Ifv91L7vocyD3zIlG/wtVuAYXr+jGZXbv+malBW
	 QScTQwr5IZSpvqw6ZcifaMhF6fsQrEadN9uqqeVvp2IK8hPqwPKIkrvuecf9Mi56F9
	 /LLuMl4JHBqluW6W7WIPC8SdcYL0qtPIrNw4tjV05y7Svj4inFnFFklybtcNeJaVqU
	 9hA8lY5vctsr1rKuOvTbPlblI9wnCtH9uE4yJYnIU/iw3wtmGf6PkUDn6gq3ZFk1Wf
	 ky3D3KGfrF3QDSxTNXA+SGCYgLjniUMhndVkEImm7hRgzyeLGoo/jW2MFntpCHonoO
	 7G8CqAv6HGW9w==
Date: Mon, 11 Sep 2023 04:45:23 +0000
To: netdev@vger.kernel.org
From: Sam Foxman <elasticvine@protonmail.com>
Cc: Sam Foxman <elasticvine@protonmail.com>
Subject: [PATCH iproute2-next] Enable automatic color output by default.
Message-ID: <20230911044440.49366-1-elasticvine@protonmail.com>
Feedback-ID: 36837664:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Automatic color should be enabled by default because it makes command
output much easier to read, especially `ip addr` with many interfaces.
Color is enabled only in interactive use, scripts are not affected.
---
 ip/ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ip.c b/ip/ip.c
index 8c046ef1..aad6b6d7 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 =09const char *libbpf_version;
 =09char *batch_file =3D NULL;
 =09char *basename;
-=09int color =3D 0;
+=09int color =3D COLOR_OPT_AUTO;
=20
 =09/* to run vrf exec without root, capabilities might be set, drop them
 =09 * if not needed as the first thing.
--=20
2.34.1



