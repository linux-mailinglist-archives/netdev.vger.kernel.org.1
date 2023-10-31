Return-Path: <netdev+bounces-45445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC61E7DD0D2
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59471B20BA9
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DC1EA84;
	Tue, 31 Oct 2023 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1BZnBi4u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B231D556
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:46:10 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8CF1
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 08:46:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc30bf9e22so25853845ad.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698767168; x=1699371968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWjKvGuQTM6nksim3BbZGxFEoUm7kQoFAT+1iXuZoP0=;
        b=1BZnBi4u5zV74Qg656lwxEcdRWi+HYkoygSN7bccUKcOlQ0Lm+hIevBl1Fla69dmHR
         ogmOyT8OLg1UKdN54fJF8gd1e+tm4i/giuN6vRFBLI27KOKlGlGMAi/+pO6kF0euif7P
         oRqXZuOQm0mBn6hIWfRRg5/sKg4d6jxLR3vY7KId9SBnC/0x2tkbZJ0jCA4+FtDNFKXg
         vgD854+BQopmjRxzZlIiJkzSrOhdO8cBVkf9BCVnP4KJTDgbKKbS0/m2AAXE3oFZPtF3
         RY/qZKWTnhOeb2kzRrRhEeoj7Gz8TijfKLHSapEJ81jHYhqALzNoDjtUoCMXdQyhBnf2
         UWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767168; x=1699371968;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWjKvGuQTM6nksim3BbZGxFEoUm7kQoFAT+1iXuZoP0=;
        b=DSIFz/IEovDX317yktw47rdOVfYzl9YsgH0acofFbkF3aVlXlMeaEv4OX1EZmGSEnw
         kZpueX19+g0ZY4ixDf8+FQVAECLDXS3l/EwxHbS2GiQaNW4jnMRiOCvomk5iYVrzlsk5
         sj/8mYXnWfW54Le6fYMXKKIbCZoajdF3hAPqNubosvdkvegyAvAVeLfWnNiZx7b/oaQq
         onReBRo6T378evZ3ABO5cBoTw6UI9mpb9rDZ+wQAcBbzoAb8QXhqMEBkR3kZWX5VSrXq
         jfNQgUWSP8YExBvZOAYpgq7yRSXKodJpr3Q+QkeWnGQbBNwbkiib1DuMgDVPoVq50MgW
         oy7Q==
X-Gm-Message-State: AOJu0YwtW9UaLcKGMnE0paPQyBKRkRfr2AJx5aUVEEogyDQQzQ5qRi22
	eSg+rOD46/0nm05poz1s2l3LwBc5SwkQ1xFB3ZLhe0ZL
X-Google-Smtp-Source: AGHT+IHyEGTmJh1BTK86LtIWWzpQjN6b1e6iIc6xbrUelQJf+rtyXC4VCQvIWsI4CucpgJdwwcZ+Yg==
X-Received: by 2002:a17:903:22c6:b0:1cc:55d4:a715 with SMTP id y6-20020a17090322c600b001cc55d4a715mr4625279plg.3.1698767167852;
        Tue, 31 Oct 2023 08:46:07 -0700 (PDT)
Received: from fedora ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001cc2c6cc39asm1480946plq.243.2023.10.31.08.46.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:46:07 -0700 (PDT)
Date: Tue, 31 Oct 2023 08:46:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: It is time to put some TCP congestion controls out to pasture
Message-ID: <20231031084603.7aacfb53@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Linux supports lots of TCP congestion control options which is good for research,
but in the current world of syszbot, it makes sense to euthanize unmaintained
especially research only algorithms.

Some options on how to do this:
    - new config option TCP_CONGESTION_CONTROL_UNSAFE?
    - move to staging
    - remove completely

What is best option?

