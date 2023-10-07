Return-Path: <netdev+bounces-38831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83F7BC9C3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 22:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D961C208B5
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B623398C;
	Sat,  7 Oct 2023 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sembritzki.org header.i=@sembritzki.org header.b="i3NL9qV6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6ED28E31
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 20:28:02 +0000 (UTC)
Received: from smtp.sembritzki.me (smtp.sembritzki.me [5.45.101.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3C93;
	Sat,  7 Oct 2023 13:27:59 -0700 (PDT)
Received: from smtp.sembritzki.me (v22018013267558932.luckysrv.de [5.45.101.249])
	by smtp.sembritzki.me (Postfix) with ESMTP id 107B99DBB0;
	Sat,  7 Oct 2023 22:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sembritzki.org;
	s=dkim001; t=1696710470;
	bh=ufJZbVtr4CsxF7gThIrXtkp7Mq1GLn405h6Rbp6YTfw=;
	h=Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 Content-Transfer-Encoding:subject:to:from:date:cc:reply-to:
	 message-id;
	b=i3NL9qV6JMJ61D29KlU+ztt/vfef8rgTXNRzZqfdPvxCBFtpNJwc28HpJQ7GQiCXp
	 mkVsmCWekAjJoAPmbN8MeYeoFf0pkleDrsoGVyFBzZRuBjq9dwhcnshu7S4cpeqIVd
	 X7iLnmMMWcXKzcwLFsz/hc09nX3XYscEG7hZ/HvJRSlm8DnkL3QYg+vxbRlMUtV0+D
	 8TYOwQz2zeO6COXsWV199V2gIV08mBDt1ZddeBUcYVdeolnM1PNMbYN6UJvKi8gViM
	 jj8J0oFM2dc2B6wMKx8RpeiNvJUPMF6ipQsDIBuDTC3TO3uXPpWQ1mjZgtG3IxPNlK
	 48WrKFLKAzE6g==
Received: (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.sembritzki.me (Postfix) with ESMTPSA id AEEF79DB9E;
	Sat,  7 Oct 2023 22:27:50 +0200 (CEST)
Message-ID: <f4659099-e21a-e4e3-5360-46057d6bf603@sembritzki.org>
Date: Sat, 7 Oct 2023 22:27:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Correct list of flags returned by SIOCGIFFLAGS in
 netdevice.7
Content-Language: en-US
From: Yannik Sembritzki <yannik@sembritzki.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, netdev@vger.kernel.org
References: <78adf50c-e8f9-d1ce-e933-418a850b6a44@sembritzki.org>
In-Reply-To: <78adf50c-e8f9-d1ce-e933-418a850b6a44@sembritzki.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please cc me on replies, I'm not subscribed to the lists.

