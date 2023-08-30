Return-Path: <netdev+bounces-31456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08378E1D1
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 00:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449F51C2091A
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96048833;
	Wed, 30 Aug 2023 22:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB376749B
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 22:00:09 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E9CC9
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:59:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso1405615e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432718; x=1694037518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2MjGNfWCKM8i5qxrysW/eiaAM56kYWd69M2+EKf96s=;
        b=mARL0EtAxBJYCxp73MPt+V5h6z3ZHfJUppbBST6+OuF1EUsrUGoUOAs+syNC2BYIoc
         sVR1dQm0S10+17rO4kXeRGjZcYWEQWtdz7B+iRNOiUC7eRByDsMPaDDRhdi2mUureXFH
         AK7KGervzjrRqDjtxOWVKBJv0A441jMEqAKP/9l0SYs+d1jQ2dSooNw5+8Ax8avPePkG
         h4VQLOrpLf3C1L2ptxM5QC7JcIaA003ZvEDsX+ig8nNBofE/fvgf2xV93xUYHcTtGaMd
         qX1ktngkSAxadRL5DD+Pe0PRf22dtuIBz+jExS7EqYKkycpMlsXoGS+4qCzZD9cp41XW
         tbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432718; x=1694037518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2MjGNfWCKM8i5qxrysW/eiaAM56kYWd69M2+EKf96s=;
        b=RYrf3kWlVF6DNhz2LKXse1/EavrlpHDlBMVkkzwQYhGH7txLfvoR9lqbh0hGyiw43C
         V5uTO29Ok4J2WLoOJECRMlDOaOon9XjIYrYbwmh7U0asquSOiV6Xn92169HQRbK2c7vO
         CbMp7+gagXPB1LzACg4dNH730udS0yGKZ0e/MJJ1TwVNvHeKvyowhm+vAsp009k0cscz
         yxdwdo7auM0SdoYDaPfsjSUHcUuGMlBIxaaDx1Zhpdmj/rOVGJnK6j+y6W1lsV1bMpGn
         AlJNZDKlHP3fAFg7e54RABDTSPdyUwbRozevlRPh7n6o9aYfbnoVqA3X4UY5eDqL7aHx
         D5nw==
X-Gm-Message-State: AOJu0Yx+EvIahfZgU1EWK0divS5u5EV0btDR7sNSTMnme80YuvdvmAks
	p5Fh1eh35eV5VLi647gMczks6A/ZJqQ=
X-Google-Smtp-Source: AGHT+IHz8/Py0548EXtoVWKOZNdBeWezIcA7hTvQEnoSeAV5PuQvRipcq/4xs2twxgSjFlv+yUXQZQ==
X-Received: by 2002:adf:eece:0:b0:319:77dd:61f9 with SMTP id a14-20020adfeece000000b0031977dd61f9mr2929107wrp.35.1693431670844;
        Wed, 30 Aug 2023 14:41:10 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l4-20020adffe84000000b003176eab8868sm33434wrr.82.2023.08.30.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:41:10 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [chrony-dev] Support for Multiple PPS Inputs on single PHC
Date: Wed, 30 Aug 2023 23:41:00 +0200
Message-Id: <20230830214101.509086-1-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
References: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Thank you very much for your prompt and kind answer. I appreciate you
taking the time to help me learn and improve my contributions.

I have now tweaked my proposal. You are absolutely right that the whole
thing is simpler and more intuitive without the sysfs control structure.

I have also removed redundant code. I hope it's better now. Let me know
what you think.

Thank you very much,
Xabier.


