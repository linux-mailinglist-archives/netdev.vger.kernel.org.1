Return-Path: <netdev+bounces-18889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B038758F9B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1D11C20D3C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50192D2FD;
	Wed, 19 Jul 2023 07:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470A101E3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:53:18 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F11FE6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:53:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B93FE1F8D7;
	Wed, 19 Jul 2023 07:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689753195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JER7MIXZgub2zzztZmE0khGE/COkEOI23ZRvzl70BW8=;
	b=CHjIZ11kbdw7qTzLJD/9SJOcWbof9wmb5x6sAw2Csa/HAt5VBRnm98F7wdBo3bGrj5ZBF4
	8Jlu01PXQH095d5iK8CcBYGG8RUeXrEBYIgAH/h5T2QBAcCYyHx+MHA+3SQ28y9aw2fvps
	F7niRRWoLMRCeEiL6QhkE/RxKeo3CbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689753195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JER7MIXZgub2zzztZmE0khGE/COkEOI23ZRvzl70BW8=;
	b=RXjEVwZ6wO2Hdj6LlFhsg4zS8Fl3Aywa81q/Qu0BBY/v9vx0K+SIRVpzT5OSm9u/ICOxPu
	lTfSEsR71l1fCtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68D613460;
	Wed, 19 Jul 2023 07:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ffRYKGuWt2QgagAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 07:53:15 +0000
Message-ID: <b6e72739-02c4-9f06-1a0b-c49f679d1140@suse.de>
Date: Wed, 19 Jul 2023 09:53:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v1 7/7] net/handshake: Trace events for TLS Alert
 helpers
Content-Language: en-US
To: Chuck Lever <cel@kernel.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
References: <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970690005.5330.12576672055397583164.stgit@oracle-102.nfsv4bat.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <168970690005.5330.12576672055397583164.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/18/23 21:01, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Add observability for the new TLS Alert infrastructure.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/trace/events/handshake.h |  160 ++++++++++++++++++++++++++++++++++++++
>   net/handshake/alert.c            |    7 ++
>   net/handshake/trace.c            |    2
>   3 files changed, 169 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


