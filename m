Return-Path: <netdev+bounces-20131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3375DC42
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 13:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361C02821BE
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDC1D2FA;
	Sat, 22 Jul 2023 11:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFB1D2F9
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 11:58:25 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB32D45
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZK02bjB7dq6dD6Wk1hI4sDS03LPxXB+zVh6kS/m8CBA=; b=WE2O/dpAyApZNj1Ro4bLO5IXNg
	7zHZGoxSek5i9hDDooDB7trzz9CdKAb88xBIKhJe4ENQu8lZOAFX5T7qHa3ahCploDfZtr0lLfn3B
	deV3wBggLRmFeMXCgvUflkoa5RsP591XMdTu06yjZncDP4+RBtVB7/jC/rOLe9UDa3DIGjbzKvXeg
	xcnYy/7WklIF/CmI8A7iNUxCQiJZxWTGBHJmrOTkxB4oB7DRZsGJyGAGO/44CmG7Fj2dmrxUc0o8/
	SgH+fnSwD0fuUm9GlvtuK+83USA6Na7Tbj/Keudod2sDNYQeD9LNNbLMOlizY9+nCdiq9IZLwPcTL
	LTv0JauA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qNBEz-000EHm-4G; Sat, 22 Jul 2023 13:57:41 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qNBEy-000G0c-JB; Sat, 22 Jul 2023 13:57:41 +0200
Subject: Re: [PATCH iproute2] Add missing SPDX headers
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20230722024236.6081-1-stephen@networkplumber.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c2d69edb-431c-0a4a-470b-a061341de080@iogearbox.net>
Date: Sat, 22 Jul 2023 13:57:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230722024236.6081-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26977/Sat Jul 22 09:27:56 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/22/23 4:42 AM, Stephen Hemminger wrote:
> All headers and source in iproute2 should be using SPDX license info.
> Add a couple that were missed, and take off boilerplate.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

