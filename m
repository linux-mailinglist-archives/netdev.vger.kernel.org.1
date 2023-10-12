Return-Path: <netdev+bounces-40234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1847C657A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784EE282A36
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EDD51D;
	Thu, 12 Oct 2023 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T+PasbDf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r8VRgjuc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2407D305
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:24:37 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51F185
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:24:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 651CB1F88C;
	Thu, 12 Oct 2023 06:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697091868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2YtcQtO97hsuZ6EM8MKLnQLs4XY10D58R09cFKnKnc=;
	b=T+PasbDfbaaU0pULptY2UBOotqFQHaTX+TRvXR4hlyWVTAVcLltl5VHXQnxYUV1XguELIX
	kkyPN1QIe1+i7cTT8dhOnhDjm+ZlYktJdAAV8woJ8CbN2YT2bJtJAOUeBIIffrqLvQMJCZ
	CLKzwgHfXqGZKJ2vNunfjXhyMK/5Pew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697091868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2YtcQtO97hsuZ6EM8MKLnQLs4XY10D58R09cFKnKnc=;
	b=r8VRgjucMWfkKYupR/CDD0k7o23arqDWD0Ykvbiwe2oiZxjqlVsRrVbrUHKw9eeqCfxH1J
	p7bF00ZNMUXFFXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A803139F9;
	Thu, 12 Oct 2023 06:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9bdeBRyRJ2UHDQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Oct 2023 06:24:28 +0000
Message-ID: <bd2c85e7-7924-4b7c-8470-6094e4d1ea1c@suse.de>
Date: Thu, 12 Oct 2023 08:24:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-12-hare@suse.de>
 <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 19:32, Keith Busch wrote:
> On Thu, Aug 24, 2023 at 04:39:18PM +0200, Hannes Reinecke wrote:
>>   	args.ta_data = queue;
>>   	args.ta_my_peerids[0] = pskid;
>>   	args.ta_num_peerids = 1;
>> +	if (nctrl->opts->keyring)
>> +		keyring = key_serial(nctrl->opts->keyring;
> 
> The key_serial call is missing the closing ')'. I fixed it up while
> applying, but a little concerning. I'm guessing you tested with a
> previous version?
> 
Yes, I did. I've tried in this series to implement the suggestion from
Sagi to store the key serial in the 'opts' structure; hence you wouldn't
need to call key_serial here. But then backed it out again as it didn't
make sense.
But that was apparently imperfectly done :-(

> Anyway, I've applied the series to nvme-6.7 since this otherwise looks
> good. I'll let it sit there a day and send a pull request to Jens if the
> build bots don't complain.

Thank you!

I had been wondering if I needed another resend...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


