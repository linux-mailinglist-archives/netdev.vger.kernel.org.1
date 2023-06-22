Return-Path: <netdev+bounces-13001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E572739A36
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEFB1C2106B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F53AA84;
	Thu, 22 Jun 2023 08:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB680C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:41:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC826B5
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687423291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLDRU0DgVHLKMtSN0SL4+wqrKqeuyjYLggk0v3Jz8BA=;
	b=QEyQK+/4hlb9f9hh+6bDzGpwjKAovTvfnvE6W0D5GUn0GAocgC4sUcmKIAhyG7gEqPsXPZ
	HO9tq3v3j3SAMx/oy89bgKO++UZ2mFkF0PUr5GBEIYEHXiNkYXGvylt6uUyYV0Q7cx+zIo
	fF9qrW6+oZ4Uabb0O6bkgUlTnEURiNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-RZ2ZGz_9OS2sMDEPdWvydw-1; Thu, 22 Jun 2023 04:41:30 -0400
X-MC-Unique: RZ2ZGz_9OS2sMDEPdWvydw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30793c16c78so10259626f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423289; x=1690015289;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLDRU0DgVHLKMtSN0SL4+wqrKqeuyjYLggk0v3Jz8BA=;
        b=WnEBgjNLqj3Yco0qDrwOZsKWwQQmaaXRSlhI5sZtYe2u9fJUYAVufoTQ/B9wQKPJBB
         A2TBFHJvkzr3Tbsr7l7ir0VNz79aRxfsAyQU1pDVR3uE9H/4Ke/n3/4SvlfGOLXMcrXg
         ITOSdMHE7IXUT6YBSbZ5CYVhiiYscTO+6XMoOgkU6aVTSuAjeeHxuhS+VIKj9OaAlPTi
         bWL/vhvzSRwWaMpoRHsHRRH3AT4Jfv6gLuNOFudnqbPl5IDO5No+4CvKESLpMWhV7tQd
         QCu9DbAu4IiAEFOBjZ0dyFt0GZveSmynn4oZ72kg6WEfq/U1M8rrPyJwnd8sBkss5Hpf
         Q/Bw==
X-Gm-Message-State: AC+VfDzoiYIcZB44HiTPMV/qdaEOzsEjMiCa+pqAIU2EnoODlJLsFkPa
	1FYgM1PP0VzDue2Kxkx2OhMIbIywz+EJwRz/Sk74lsiLAG2tSW2aaZ0OTjrC5OsR1XXqFjcYhyh
	+9VkcHXmH5AO6CzNV
X-Received: by 2002:a5d:4811:0:b0:30f:c47f:27ad with SMTP id l17-20020a5d4811000000b0030fc47f27admr17093906wrq.28.1687423288962;
        Thu, 22 Jun 2023 01:41:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zAnPnp2VylPjRjt2iTmJZd7rhZ/iD44REfL4MTjkjtHKZxA7ykn6cbnmMw6JeQU5KL+GeBA==
X-Received: by 2002:a5d:4811:0:b0:30f:c47f:27ad with SMTP id l17-20020a5d4811000000b0030fc47f27admr17093884wrq.28.1687423288664;
        Thu, 22 Jun 2023 01:41:28 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d558f000000b0030647d1f34bsm6662063wrv.1.2023.06.22.01.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:41:27 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e53ffd61-4b2d-4acd-7368-8df891aa0027@redhat.com>
Date: Thu, 22 Jun 2023 10:41:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: Re: [RFC bpf-next v2 00/11] bpf: Netdev TX metadata
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230621170244.1283336-1-sdf@google.com>
In-Reply-To: <20230621170244.1283336-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 21/06/2023 19.02, Stanislav Fomichev wrote:
> CC'ing people only on the cover letter. Hopefully can find the rest via
> lore.

Could you please Cc me on all the patches, please.
(also please use hawk@kernel.org instead of my RH addr)

Also consider Cc'ing xdp-hints@xdp-project.net as we have end-users and
NIC engineers that can bring value to this conversation.

--Jesper


