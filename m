Return-Path: <netdev+bounces-61454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F6823CBD
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336971F2347B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF921DFE9;
	Thu,  4 Jan 2024 07:26:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E91EB23
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae9b3.dynamic.kabel-deutschland.de [95.90.233.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 16D6D61E5FE01;
	Thu,  4 Jan 2024 08:26:19 +0100 (CET)
Message-ID: <7bfd7069-8222-4388-bc1f-d4e77093b503@molgen.mpg.de>
Date: Thu, 4 Jan 2024 08:26:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Convert ret val type
 from s32 to int
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
References: <20240103101135.386891-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
In-Reply-To: <20240103101135.386891-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Re-sent with diff removed, so message size limit of 90 kB of list 
Intel-wired-lan is met.]

Dear Jedrzej,


Thank you for your patch.

Am 03.01.24 um 11:11 schrieb Jedrzej Jagielski:
> Currently big amount of the functions returning standard
> error codes are of type s32. Convert them to regular
> ints.

Please make use of the full allowed text width of 75 characters per line.

Also please add the motivation. Why are regular ints better?

[…]


Kind regards,

Paul

