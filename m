Return-Path: <netdev+bounces-34636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE77A4ECE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA421C2145C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E272376F;
	Mon, 18 Sep 2023 16:26:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481B20B1A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:26:48 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9677EC8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:26:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79536bc669dso163919939f.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695054407; x=1695659207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCMrFuGDqjX9VMKx6pC2Ltdzj+Xy9TLR+v1gqts5ts0=;
        b=wkxOCCMYPUS46H/ImqAS2xhT9molHUX+d0eSUGGGoHKnO8WM1Ely1TlSF572t7E1qj
         bGOmXXrpAaNYeq6FhdkZSDsgMIRfo8FxELIz2NLGAjCCO3M621erNR4NrJ0FzvcpuI7B
         sqnmclocJXBr++zUk/LnDp0/Qz9oz38dopEdAC2A7JWtKsXeDh4DuxHjaZ8EFz9TQacC
         +Jk1x2t9gA5X87uk/ajkWd+AkksYQKgoLH1pLoIwhuX6s/d98fmOMysb5/wlnfSf7UXB
         V4Dc0d4BpuEtN7IaxZfjusqMKolZ5L+zVs/HXqKD6mX3Mwm85noDY6yeKwbciJZrOvQG
         R1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054407; x=1695659207;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCMrFuGDqjX9VMKx6pC2Ltdzj+Xy9TLR+v1gqts5ts0=;
        b=G+TkPj76NiEedC4D+qTGuXTgBBUTSoYBFlG9eDnYzvwD4ZNRngEnIRut6cA2wCvWQ8
         gYxWt/Re7BDFT1mysUO5LfL5+GlbyVS++j1aJsTVQCtplYxWkoaJlf2b0tO/QujwLbPt
         FGuYTdKIIQsPZls3msrnlWqjF4sEPWYwa6UcUDa5w5Kn0wO0phQecFPXjUAS6cDKBRFb
         s3iptYzTjKX5UZxX2wwzWXo50h4gLoF9ckVt747B+ilVCuheebfoNiY9Ud3ferhlNMIP
         k/iMIOgztF1sfwG706Nu5AqUbKNPisQYw7fDNXjw0f3E2GZI3qW+HqpgOymCvBs8qW0o
         jSwg==
X-Gm-Message-State: AOJu0YySgRZ0sGrXUh7cSuptpQpJ0uxvCR1EwHmCi7bJ19uZmFf/Fk8N
	Pbp/ovTe/BgkWIMdJXotP5xixFGRJerEKijL0XYA7w==
X-Google-Smtp-Source: AGHT+IGh5AM2vnHM/7JADo8uDqOdIPl6hCsp83P+urMSwv2DJNJfbh85la3ZC8fJ1vM349qbAWoaXA==
X-Received: by 2002:a05:6e02:13e9:b0:34c:dd54:10c6 with SMTP id w9-20020a056e0213e900b0034cdd5410c6mr11065873ilj.12.1695054406847;
        Mon, 18 Sep 2023 09:26:46 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id w12-20020a63a74c000000b00553b9e0510esm6956663pgo.60.2023.09.18.09.26.46
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:26:46 -0700 (PDT)
Date: Mon, 18 Sep 2023 09:26:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Github mirror of iproute2 has moved
Message-ID: <20230918092644.313bcea2@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The github mirror of iproute2 has moved from shemminger/iproute2 to iproute2/iproute2
This is allow for more maintainers in the future.

