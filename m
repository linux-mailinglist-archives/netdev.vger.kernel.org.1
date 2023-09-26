Return-Path: <netdev+bounces-36306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E97AEDBB
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D302B281489
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C0D28DCB;
	Tue, 26 Sep 2023 13:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB027728
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 13:10:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348110C
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695733830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
	b=NGRj70LkD0MMjgiHDYGjLXrP3Ob3DD4gxhD48/ghqOtA+Ddhkvx+LdVeMirh9jM1LCZQnA
	fiTcYaoYz1UhuRDLTRZERMKkXWGG4lTIgTjEtGlMAhHbuLU5XTOtROGyeR7P7zEmNEdhuM
	yNVoObEm3E9cmBkq1/p0X5zPqPuSjfg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-nd2pFYVBPgS12w7ZthBj0g-1; Tue, 26 Sep 2023 09:10:28 -0400
X-MC-Unique: nd2pFYVBPgS12w7ZthBj0g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a647551b7dso481748166b.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733827; x=1696338627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
        b=AREriMnf+KTMOExXNZymKW3pQzGyXfkCVV7vKnj9PirtA0uNA5ugZOU2hl8jTcSiBi
         NW4nkeyf0GJwJA0bV4lgfwS7vZt6Qf2UsTW5XjZ7gPQb4n6C+W2IKl6Kcv09zMI5FD3J
         ziATROs7WBpoT+wNf7p0xncP8S91XRioMEO1/sOt6CfJML1JXqZyiUzaO5/GvSKmVhPe
         Fc6RGJFqCM4Tgxc5NFS+w3/xzIFpi0mbKl9Tgxk7/js6qOiilYbGC0aKb9ACY8qLw4DM
         qrNBHGm6hsKMlbByWBQ/t7B6ZLwRxLXHeItyYlmLaz+fUXNk+06pZV+yZI1meWK9tVGm
         UXbw==
X-Gm-Message-State: AOJu0YzgcHcqg5utmND6+N8qGCpCtYZSL/4rCS3L1iEyeHLP2P2pqEm8
	YAXxTxOjoBdc0WSB+GE1r6C9AP3lNszhGqNJEQvd7DI0cNxiMu5G8OtJH374Vg6U2vFyjt+LFnA
	fQNfSaYiWghc5tT4y
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id hp11-20020a1709073e0b00b009ae5a56be32mr4084902ejc.38.1695733827489;
        Tue, 26 Sep 2023 06:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhr8aocGYblGQIkanfvgdcYkJGgnxjzR7Ndhh5heLB5k61gMBi2Cpl5HUKWX7e6D9TEIPTRA==
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id hp11-20020a1709073e0b00b009ae5a56be32mr4084743ejc.38.1695733825833;
        Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090634ca00b00997e00e78e6sm7780777ejb.112.2023.09.26.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Date: Tue, 26 Sep 2023 15:10:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <zurqqucjbdnyxub6u7ya5gzt2nxgrgp4ggvz76smljqzfi6qzb@lr6ojra35bab>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arseniy,

On Fri, Sep 22, 2023 at 08:24:16AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7

Thanks for the series.
I did a quick review highlighting some things that need to be changed.

Overall, the series seems to be in good shape. The tests went well.

In the next few days I'll see if I can get a better look at the larger 
patches like the tests, or I'll check in the next version.

Thanks,
Stefano


