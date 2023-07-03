Return-Path: <netdev+bounces-15093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A784745A0E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AB61C20318
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293784691;
	Mon,  3 Jul 2023 10:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC74433
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:20:59 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DFBE
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 03:20:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9D731FD77;
	Mon,  3 Jul 2023 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688379652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYbDQTr7JXNGP7jzRXCrBeOE4JiYLSrz8vehK49e4RE=;
	b=s2Rb/gh5n9uYAqETsf9WTciIL0Z/Q4tMTEAe0E6nBtSQ6PhfEzoIKImiXIVogI0qwrCpjB
	OVqUqenCCaoZiR7Q5ZeWioxUbFB0jYkIJwZDIC1EiQxN4uj5sHGEZJXBlG571ITGjJMgx/
	SsajuKNF/2uj+DwmN8e/M4agRMykbfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688379652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYbDQTr7JXNGP7jzRXCrBeOE4JiYLSrz8vehK49e4RE=;
	b=DJWSPBsS5DccRxvXwdrUEJvpomC4IZfsjBSX1bD7Waylqi6fex5OLsIhh/kcIfi0bKBL3s
	NPWv1/9Q6xyN4BDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3844138FC;
	Mon,  3 Jul 2023 10:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tYR0JwShomQ3MAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 10:20:52 +0000
Message-ID: <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
Date: Mon, 3 Jul 2023 12:20:52 +0200
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
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/3/23 12:08, Sagi Grimberg wrote:
> 
> 
> On 7/3/23 12:04, Hannes Reinecke wrote:
>> Hi all,
>>
>> here are some small fixes to get NVMe-over-TLS up and running.
>> The first three are just minor modifications to have MSG_EOR handled
>> for TLS (and adding a test for it), but the last two implement the
>> ->read_sock() callback for tls_sw and that, I guess, could do with
>> some reviews.
>> It does work with my NVMe-TLS test harness, but what do I know :-)
> 
> Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
> david?

Yes. This patchset has been tested on top of current linus' HEAD, which 
includes the MSG_SPLICE_PAGES series (hence the absence of patch hunks 
for ->sendpage() and friends).

Cheers,

Hannes


