Return-Path: <netdev+bounces-14429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1EC74129C
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EFA1C203DB
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F03C148;
	Wed, 28 Jun 2023 13:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734EC12E
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:37:00 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607362D69
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 06:36:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f954d7309fso1288165e87.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959417; x=1690551417;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c69lPkigCz+sbD7n3KTlhgYNivhfv3My0q2Cb4AieDg=;
        b=VxlG8Toj5jD4DEmax68TNpLODmpljqTLHeWE7NpzXySJ+ypb986Qzjee8+JiqeHmk2
         sdUHwKLmWUOrxr4iPQefgs510fjWAPqazxJC1Hv2+Ep5EJMn6la7Hr851VvL4ovPaKy1
         JTQnvSRC6/HYgj4qr5YWwWAjnUpwbWvwvzmV3A6wKPNDZ/jVxjCW2lw75lc/Re6X8mLk
         I3M6t+5xh9l8Iv+A9UPrkhSKPpxTs02rIPda/deSniAL40inc7vYfkEATtng4PwUg+jm
         kp7A4Gw6z3H8S8WfGEuI4L1yKfr2/Q2WQ2oAd/nbVhMnba8rZbbXnLSrrT7mnGX++//f
         BK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959417; x=1690551417;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c69lPkigCz+sbD7n3KTlhgYNivhfv3My0q2Cb4AieDg=;
        b=VIUnEn+2Y9T+gXuiNej5CvIMuwF52vHIKgR63GrEI7M98nDCslD7yISM1MVWLF0U0y
         fVTK6boVT5T6HA38mLMWt31cko35cNksGuqz5N1PJRpAKRQRSVlHNRQlYA0O8kWWfi7q
         22GxXJCEvng+yduX381jSDQtlUqfe+P65xbnCHBcjnXNeOGvkChSbW2nmiX9sMO3NFKD
         OAU/fxZxYBXSnCKri1JNc0QpYduSfM1HYNr5iSNZ4226s5McuJZU9+Bt7WWQXFthLskf
         Rztl4CO2a7/x9Sik+z7ufRQfAos0kui6nipRKwqTviM/cuJUWnpTGuoJGmXI8g9PzejS
         9pVg==
X-Gm-Message-State: AC+VfDwZ/bLDN7z1st88vdFYMxwkmoLC9ZKATkCyBYNz6Sp5c3UYbtAa
	sLxnqdKdaoplhTX54Or//FejqIedlBjKHL/rG79gCYpi61I=
X-Google-Smtp-Source: ACHHUZ4b63twVktw9OV9rgviDlIugKQa9P+nQA7wqA42lICa8QHV19SItZNM/w+6zEtEADTuynSWlTAF2CCC328CKzY=
X-Received: by 2002:a05:6512:220e:b0:4f8:a80c:896a with SMTP id
 h14-20020a056512220e00b004f8a80c896amr738438lfu.7.1687959417216; Wed, 28 Jun
 2023 06:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Wed, 28 Jun 2023 19:06:45 +0530
Message-ID: <CABTgHBsEfgr8wQNF-YGR9mWMOb3bSESRdO4YVL+8+V6VA-PVuw@mail.gmail.com>
Subject: Routing in case of GRE interface under a bridge
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I have a "l2gre0" and "eth0" interface under the bridge "br0". If a
packet comes to eth0 interface with a destination IP address say
10.10.10.1 which is not known on the Linux system, as there is no
route for 10.10.10.1, will the l2gre0 interface encapsulate this
packet and send it across the tunnel ?
The other endpoint is on a different Linux system with another l2gre0
interface having IP address 10.10.10.1

Thanks
N Gadre

