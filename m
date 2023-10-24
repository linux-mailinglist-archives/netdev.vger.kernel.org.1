Return-Path: <netdev+bounces-43969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB57D5A48
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691061C2080C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632833B7BF;
	Tue, 24 Oct 2023 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IH9MDInO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9C3B7A9;
	Tue, 24 Oct 2023 18:16:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4A111;
	Tue, 24 Oct 2023 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hhkaid6m1cJ5Rg5KluZpBpQamtt68cnL8onm3YM3b9E=; b=IH9MDInO6XrALHPT+/UD1ghKBD
	JVn2oZeYdIeBPEMvX2FSN5zC/RyBEW9Q1o9B3KrVxbzE8IDycdMD5RBHiZku/olDYJrCFliOeL8qe
	DZ8hTNpP+9rWBRuq/AZsbpU3Hk80oy58n5I2M0GO8GtJILte9PaxfqpVQCjGu51+bPlBt3wkeWK3h
	lOKNyjlkGLwI2X3QIykbQQVkFeQ2z1dniCbvMFpLxH9xtXNlr6Kx19UxiYKrFj2GMYc9ciOgW4xyQ
	OTptvITioHatz+UzlUcMlLYG5915qBh3M7g3IKoeIMmUEDED4HkUXNr/GYc+aZw0C94rPMjEXsxD1
	Ppu5wtTQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvLxQ-0005ba-OY; Tue, 24 Oct 2023 20:16:48 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvLxQ-0009eK-BX; Tue, 24 Oct 2023 20:16:48 +0200
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net
 device
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 kuba@kernel.org, andrew@lunn.ch
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-2-daniel@iogearbox.net> <87msw8ovfn.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3191e98a-dd6f-8108-91fb-ff5ce76f015f@iogearbox.net>
Date: Tue, 24 Oct 2023 20:16:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87msw8ovfn.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/24/23 6:07 PM, Toke Høiland-Jørgensen wrote:
[...]
> I like the new name - thank you for changing it! :)

I'm glad :) and thanks for the review!

> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 


