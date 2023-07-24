Return-Path: <netdev+bounces-20258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030075EC3E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F5281396
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49315BB;
	Mon, 24 Jul 2023 07:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30151117
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 07:10:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC764137
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 00:10:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9AD20534;
	Mon, 24 Jul 2023 07:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690182643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bs8GFqJdLR6YpYEb/PQpUFtoXE+F2xMFCO/25AMcKi4=;
	b=fBa9aV8+gRtjHML/OsSesIUP51mYQFhkYM/7fgqPo5h43uo7T5Akhavq8I0fiBZSrIDmHU
	x2L/4XxXEVCYQl6+x0lqRABaixaogDDqdgl2UNSGsyvx9hQuDydXAC/18jBj8KwsBIFKJs
	o+DVXYOrCVlwHbTEx/JPbw0uxVq62KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690182643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bs8GFqJdLR6YpYEb/PQpUFtoXE+F2xMFCO/25AMcKi4=;
	b=oWujHEFreCiu7vRYWv50U9iY0dW6CLto56R8LC7N39+g4VB41cwOT+oD0Lu9NaCZzKVPuf
	X//7dRdS+blS44AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1065413476;
	Mon, 24 Jul 2023 07:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id R36cAvMjvmQMWQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 24 Jul 2023 07:10:43 +0000
Message-ID: <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
Date: Mon, 24 Jul 2023 09:10:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230721190026.25d2f0a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/22/23 04:00, Jakub Kicinski wrote:
> On Fri, 21 Jul 2023 16:35:17 +0200 Hannes Reinecke wrote:
>> here are some small fixes to get NVMe-over-TLS up and running.
>> The first set are just minor modifications to have MSG_EOR handled
>> for TLS, but the second set implements the ->read_sock() callback for tls_sw
>> which I guess could do with some reviews.
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> Sagi, I _think_ a stable branch with this should be doable,
> would you like one, or no rush?

I guess a stable branch would not be too bad; I've got another
set of patches for the NVMe side, too.
Sagi?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


