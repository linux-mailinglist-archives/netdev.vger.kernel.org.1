Return-Path: <netdev+bounces-56318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330C80E859
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AD62812E5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E735914E;
	Tue, 12 Dec 2023 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="G/fV2qeH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E49FD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:57:23 -0800 (PST)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4SqDYL0dhDzDrRM;
	Tue, 12 Dec 2023 09:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1702375041; bh=T2p932hhf/t1ELCg3vzJT0DL6+JnVOd0apGLSkwLy2g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=G/fV2qeH0CGR7kNB/gzf8HB8A9xjj9Ew9/U9D5F6LjF+Iaflm42OZMNFExgJVlPPB
	 7cLYTVyMtu3WD2WlbnDH6kqBKRNoO9uv+VH0DJ270AphegvrFWvdH5EB/RAbAiGfFg
	 iC5pc0WdFLJGx0NSsED+e0Fk01oRUKE+SvtkEyKA=
X-Riseup-User-ID: D1B3507E71595E12C760C7F32A909C3EC4E44D597829D7D5FEBF00FC9C995999
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4SqDYJ60zmzJn4h;
	Tue, 12 Dec 2023 09:57:08 +0000 (UTC)
Message-ID: <6715f514-f3a7-4297-8720-53872eea8056@riseup.net>
Date: Tue, 12 Dec 2023 10:57:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Preferred term for netdev master / slave
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
References: <m2plzc96m4.fsf@gmail.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <m2plzc96m4.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2023 15:05, Donald Hunter wrote:
> I'm working on updates to the YNL spec for RTLINK and per
> Documentation/process/coding-style I want to avoid any new use
> of master / slave.
> 
> Recommended replacements include:
> 
>      '{primary,main} / {secondary,replica,subordinate}'
>      '{initiator,requester} / {target,responder}'
>      '{controller,host} / {device,worker,proxy}'
> 
> Is there an existing preference for what to use in the context
> of e.g. bridge master / slave?
> 

Hi Donald,

In other projects like NetworkManager, rust-netlink libraries.. the 
terms that are being used in the context of linux bridging are 
controller / port.

> If not, then how about one of:
> 
>      primary / secondary
>      main / subordinate
> 
> Thanks!
> 

Thanks!

