Return-Path: <netdev+bounces-15117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B973B745C16
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE8D1C208D2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA10E56C;
	Mon,  3 Jul 2023 12:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF32E565
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:19:29 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C721705
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:19:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1541219D5;
	Mon,  3 Jul 2023 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688386755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZWI44BtZbtwIcB7Sw25mLVy0cDxq8hKvbK6+3lG76E=;
	b=kkQwVSPef5ix3XQX/EBGuw3XtHGZI/gjs8ZWoYGzxrDhX+s3bdgtNVqi1x1JenqQm23t3M
	HsEGEIWqYgJ6L5uraI9+EwZR6bgMGu+/KP8dZYSc2JNOsH74c8nr5ovAAYZhvtz3dDt541
	E6/3/eW84SgisA6C15GhzrYUqHrDfCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688386755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZWI44BtZbtwIcB7Sw25mLVy0cDxq8hKvbK6+3lG76E=;
	b=FPZu/kaG6QOer41a6Kvj2J+04euiwrF72OMe/FaLZTXVf79X2tZkATC9y59Q3fh8CoeIMx
	riohXNRLloEqshAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD0E913276;
	Mon,  3 Jul 2023 12:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zyjQLcO8omRKcgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 12:19:15 +0000
Message-ID: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
Date: Mon, 3 Jul 2023 14:19:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
In-Reply-To: <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 14:13, Hannes Reinecke wrote:
> On 7/3/23 12:20, Hannes Reinecke wrote:
>> On 7/3/23 12:08, Sagi Grimberg wrote:
>>>
>>>
>>> On 7/3/23 12:04, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> here are some small fixes to get NVMe-over-TLS up and running.
>>>> The first three are just minor modifications to have MSG_EOR handled
>>>> for TLS (and adding a test for it), but the last two implement the
>>>> ->read_sock() callback for tls_sw and that, I guess, could do with
>>>> some reviews.
>>>> It does work with my NVMe-TLS test harness, but what do I know :-)
>>>
>>> Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
>>> david?
>>
>> Yes. This patchset has been tested on top of current linus' HEAD, 
>> which includes the MSG_SPLICE_PAGES series (hence the absence of patch 
>> hunks for ->sendpage() and friends).
>>
> Well, of course, spoke too soon.
> 'discover' and 'connect' works, but when I'm trying to transfer data
> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
> sock_sendmsg() as it's trying to access invalid pages :-(
> 
> Debugging to find out if it's my or Davids fault.
> 
Hehe.

Wasn't me. Crashes even without TLS.
Sagi, does current linus' HEAD (I've tested with e55e5df193d2) work for
you (traddr tcp 127.0.0.1)?

Cheers,

Hannes


