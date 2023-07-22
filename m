Return-Path: <netdev+bounces-20130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45D75DC3C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 13:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597FE28212F
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48918B16;
	Sat, 22 Jul 2023 11:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDD182DF
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 11:58:23 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C459735B8
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P1sjWBAvljF5q+O7gvEynTlvQ0SC/wqvCzvqNcVGTF4=; b=PemB6vZ8LdWdkra5cYqb/K5IRP
	N9iAFlg77WV7DFc3PdFOkUKERTBeVzhhDzeKeZcNP7H0gyM7Bmu/NatSX4JCnzk3qBzRF8IZ/WP77
	moQeDbiAgwuKy9h2tU/8Wl1aTtcZlaoKjm5k2NLUE/hX9QnhSqDUj6CSRTdm/4iJX7xI1bSXrCXwY
	9PyfweFT1CdGSwRwmcYaMjqPBPkz7GrM/lX2m6qIRKodF7lNB3+Y9nldaFhfQ2QUI3Ljt9wUxqHT8
	SV/IlP1NpUFeO0cEZ39zNz8Od73vGEUVCJQ1CY3GZ1oj8XWHtf7mkpgbFQKwM+FJuew7lyfqotNYZ
	3XXy01ng==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qNBEj-000ED1-56; Sat, 22 Jul 2023 13:57:25 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qNBEi-000EUD-Jz; Sat, 22 Jul 2023 13:57:25 +0200
Subject: Re: [PATCH iproute2] include: dual license the bpf helper includes
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20230722024120.6036-1-stephen@networkplumber.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bd1ecb37-d0bb-fc37-3036-8d57c8211e85@iogearbox.net>
Date: Sat, 22 Jul 2023 13:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230722024120.6036-1-stephen@networkplumber.org>
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

On 7/22/23 4:41 AM, Stephen Hemminger wrote:
> The files bpf_api.h and bpf_elf.h are useful for TC BPF programs
> to use. And there is no requirement that those be GPL only;
> we intend to allow BSD licensed BPF helpers as well.
> 
> This makes the file license same as libbpf.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

