Return-Path: <netdev+bounces-32605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D36798AD7
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC911C20C58
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD812B92;
	Fri,  8 Sep 2023 16:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CA63CD
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 16:48:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5661FCF
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694191692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSHaK98jP52OExjU5ccVlB5Izk6T25mAruQGfLMmkDo=;
	b=g+A6DZSUGHxwVC2TI0vlRXUstZUtQa94g1qQ6Zu3pgo9XCFzJN9T4F1tWumsryElr0WSBn
	1t4S/xIAfT60k2pAl+VzONVXWw03FNGE6tCIhQ4BodBfIc3GWDrTNWhJ3L1sl3zO81krhU
	Ya1t8ojhnYxDaydHlv7V3H84GKXqVj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-kpdmp6QyMU6pGY-JwlVSow-1; Fri, 08 Sep 2023 12:48:09 -0400
X-MC-Unique: kpdmp6QyMU6pGY-JwlVSow-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401db25510fso17106575e9.1
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 09:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191688; x=1694796488;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSHaK98jP52OExjU5ccVlB5Izk6T25mAruQGfLMmkDo=;
        b=uPDlQ3NGJQuroMD1C8mYOqfSWQI369kZwPed+HlpNz0CEHFVZs5GlGmLDNQpya4Akg
         q1A/FkFzWB5L848p1Wb90eKCMS3WRHfYh9bSaTnO/v19r+OUuZqiVW5RWVuqKqTMegqZ
         zZ2TJL+JdnF0MkU9HIPPWSVwg2h2cpXi6UV7XT/tgVwN8d4GYZfVgY3gT7pYmhxitUTN
         luv2Ct6+gPvxBcgRmE4GZuGzfjNumpa9COh/4wuUObPn7tOOHYplZufEMiwDNT4AHSz3
         wM72X4016bIie6I8iK9erZaLmPKJu1NBkpeHJuIZgQhCcgawk8LNFmdsVVVzE5UzKBpS
         1nEw==
X-Gm-Message-State: AOJu0Yzn3NGNwTLhCIpBkQMGjYa+MYvI+x7V0mxcopCRFxT9H9Wgj3PY
	ou5G8rVp3KsgpEVPQ4E42B+yO7K8KFbTqMaJxOmGjZlqokcQ1GJJr1UXOrTbcOADaNqI/qEqRBj
	SvgphP2xvdxcOYM3Z
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr2466127wms.3.1694191688116;
        Fri, 08 Sep 2023 09:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6vY3W7GArv4nn32cMyQOaB0I2anFfX3q4OwjsxS4Vyij+Hd9beJRo+Vd7kIAet301I2JQHA==
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr2466087wms.3.1694191687701;
        Fri, 08 Sep 2023 09:48:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:d00:61ea:eace:637c:3f0f? (p200300cbc7200d0061eaeace637c3f0f.dip0.t-ipconnect.de. [2003:cb:c720:d00:61ea:eace:637c:3f0f])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fed630f560sm2398991wmj.36.2023.09.08.09.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 09:48:07 -0700 (PDT)
Message-ID: <8698ba1f-fc5d-a82e-842b-100dc8957f2f@redhat.com>
Date: Fri, 8 Sep 2023 18:48:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
 Peter Xu <peterx@redhat.com>, Lei Huang <lei.huang@linux.intel.com>,
 miklos@szeredi.hu, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Boris Pismenny <borisp@nvidia.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-mm@kvack.org, v9fs@lists.linux.dev,
 netdev@vger.kernel.org
References: <20230905141604.GA27370@lst.de>
 <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com>
 <20230908081544.GB8240@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: getting rid of the last memory modifitions through gup(FOLL_GET)
In-Reply-To: <20230908081544.GB8240@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08.09.23 10:15, Christoph Hellwig wrote:
> On Wed, Sep 06, 2023 at 11:42:33AM +0200, David Hildenbrand wrote:
>>> and iov_iter_get_pages_alloc2.  We have three file system direct I/O
>>> users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
>>> to convert fuse to iov_iter_extract_pages which I'd love to see merged,
>>> and we'd need equivalent work for ceph and nfs.
>>>
>>> The non-file system uses are in the vmsplice code, which only reads
>>
>> vmsplice really has to be fixed to specify FOLL_PIN|FOLL_LONGTERM for good;
>> I recall that David Howells had patches for that at one point. (at least to
>> use FOLL_PIN)
> 
> Hmm, unless I'm misreading the code vmsplace is only using
> iov_iter_get_pages2 for reading from the user address space anyway.
> Or am I missing something?

It's not relevant for the case you're describing here ("last memory 
modifitions through gup(FOLL_GET)").

vmsplice_to_pipe() -> iter_to_pipe() -> iov_iter_get_pages2()

So it ends up calling get_user_pages_fast()

... and not using FOLL_PIN|FOLL_LONGTERM

Why FOLL_LONGTERM? Because it's a longterm pin, where unprivileged users 
can grab a reference on a page for all eternity, breaking CMA and memory 
hotunplug (well, and harming compaction).

Why FOLL_PIN? Well FOLL_LONGTERM only applies to FOLL_PIN. But for 
anonymous memory, this will also take care of the last remaining hugetlb 
COW test (trigger COW unsharing) as commented back in:

https://lore.kernel.org/all/02063032-61e7-e1e5-cd51-a50337405159@redhat.com/


> 
>>> After that we might have to do an audit of the raw get_user_pages APIs,
>>> but there probably aren't many that modify file backed memory.
>>
>> ptrace should apply that ends up doing a FOLL_GET|FOLL_WRITE.
> 
> Yes, if that ends up on file backed shared mappings we also need a pin.

See below.

> 
>> Further, KVM ends up using FOLL_GET|FOLL_WRITE to populate the second-level
>> page tables for VMs, and uses MMU notifiers to synchronize the second-level
>> page tables with process page table changes. So once a PTE goes from
>> writable -> r/o in the process page table, the second level page tables for
>> the VM will get updated. Such MMU users are quite different from ordinary
>> GUP users.
> 
> Can KVM page tables use file backed shared mappings?

Yes, usually shmem and hugetlb. But with things like emulated 
NVDIMMs/virtio-pmem for VMs, easily also ordinary files.

But it's really not ordinary write access through GUP. It's write access 
via a secondary page table (secondary MMU), that's synchronized to the 
process page table -- just like if the CPU would be writing to the page 
using the process page tables (primary MMU).

> 
>> Converting ptrace might not be desired/required as well (the reference is
>> dropped immediately after the read/write access).
> 
> But the pin is needed to make sure the file system can account for
> dirtying the pages.  Something we fundamentally can't do with get.

ptrace will find the pagecache page writable in the page table (PTE 
write bit set), if it intends to write to the page (FOLL_WRITE). If it 
is not writable, it will trigger a page fault that informs the file system.

With an FS that wants writenotify, we will not map a page writable (PTE 
write bit not set) unless it is dirty (PTE dirty bit set) IIRC.

So are we concerned about a race between the filesystem removing the PTE 
write bit (to catch next write access before it gets dirtied again) and 
ptrace marking the page dirty?

It's a very, very small race window, staring at __access_remote_vm(). 
But it should apply if that's the concern.

> 
>> The end goal as discussed a couple of times would be the to limit FOLL_GET
>> in general only to a couple of users that can be audited and keep using it
>> for a good reason. Arbitrary drivers that perform DMA should stop using it
>> (and ideally be prevented from using it) and switch to FOLL_PIN.
> 
> Agreed, that's where I'd like to get to.  Preferably with the non-pin
> API not even beeing epxorted to modules.

Yes. However, secondary MMU users (like KVM) would need some way to keep 
making use of that; ideally, using a proper separate interface instead 
of (ab)using plain GUP and confusing people :)

[1] https://lkml.org/lkml/2023/1/24/451

-- 
Cheers,

David / dhildenb


