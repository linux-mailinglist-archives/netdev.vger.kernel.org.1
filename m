Return-Path: <netdev+bounces-14258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE773FCD2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9877F1C209FD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541318008;
	Tue, 27 Jun 2023 13:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AA171C5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 13:26:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EF1737
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687872364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1RsGs/Oy7XaTXoMXOFwYlyEKnB3c+tNOHwOA6wYMVE=;
	b=G0X9nUhttHqfipaw7dW1+AkFCUB1v9PUg+5TBAbMuPMXqEMf4FUp4som/yKTUh+ScTa8nW
	5RgFJqEIGitpufFeSkUMqQdlhe/dNkQUMbqMhpVEN8EjbhbYRnzEdiCEIPDhOyKh4Vew0Z
	Ubaw2awcVDj5CLP1kx/Fqw3sB3aqOdY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-MtUBNtirMtKut58NbAXWQg-1; Tue, 27 Jun 2023 09:26:03 -0400
X-MC-Unique: MtUBNtirMtKut58NbAXWQg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39edcb52625so3853427b6e.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872363; x=1690464363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1RsGs/Oy7XaTXoMXOFwYlyEKnB3c+tNOHwOA6wYMVE=;
        b=J+tAU3z3KvFgIGp3HSZgWZkCyRQ5PBkSBiHvEklF3uAU8YWFJC4kAeA6rWwaHSN9KG
         mDJHRVr6bYfdjvmCA4Ur2NpqGOZNyI53wb/z7XfEC3NClARTZEZvTLbB855cUW0xvSCJ
         6xtzMxH8T1qyAXoyszo9JP8iAFpZiVSiFjQI0jQyV0mPN2km8OmnHoDnF6Npp2VLfW2+
         WSzdDVhSeqdV3fbBfv9yigtHmoiYrnMVjIdR1+sUOmZJQ/qXy2Uwn1Bx7faIF+LvkqEP
         HDmVU8yb8yFPHi7Y01JZareVUqcVdf8MjgXG3qxgiWlcvn+hx+fqozUEilQgF18F894v
         w3Gg==
X-Gm-Message-State: AC+VfDyq+ilqN4jr0BlFIKUCI4wDFeOPWqce2i6Y96bobTq/SWtkRnkA
	y84Wkfzfga1R9vNT3Cyr6qnhJOstEaUN+vRDX5G0R18ukTZgE9VqHBFZYwIZYVt/cKsNI9N7fzq
	xmMnRomDG4DPKPV5M
X-Received: by 2002:a05:6358:ed9:b0:12f:22c1:66aa with SMTP id 25-20020a0563580ed900b0012f22c166aamr22209963rwh.3.1687872362784;
        Tue, 27 Jun 2023 06:26:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ct1+vuM40E/glXJ0Z8sHGosVgklX3+elTmV7NxPnN4Rqt8k0kdWNrsXNDAwiy/A0QTuLYPw==
X-Received: by 2002:a05:6358:ed9:b0:12f:22c1:66aa with SMTP id 25-20020a0563580ed900b0012f22c166aamr22209940rwh.3.1687872362494;
        Tue, 27 Jun 2023 06:26:02 -0700 (PDT)
Received: from localhost ([37.163.11.144])
        by smtp.gmail.com with ESMTPSA id j13-20020a05622a038d00b003ff44c0487asm4533762qtx.43.2023.06.27.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:26:02 -0700 (PDT)
Date: Tue, 27 Jun 2023 15:25:56 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mptcp@lists.linux.dev,
	martineau@kernel.org, geliang.tang@suse.com
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: fix 'delete and re-add'
 test
Message-ID: <ZJrjZJ4qc5sMyr75@renaissance-vector>
References: <cover.1687522138.git.aclaudi@redhat.com>
 <927493b7ba79d647668e95a34007f48e87c0992a.1687522138.git.aclaudi@redhat.com>
 <94a77161-2299-e470-c0d5-c14cf828cd92@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94a77161-2299-e470-c0d5-c14cf828cd92@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 01:31:07PM +0200, Matthieu Baerts wrote:
> Hi Andrea,

Hi Matthieu,
Thanks for your review.

> 
> On 23/06/2023 14:19, Andrea Claudi wrote:
> > mptcp_join '002 delete and re-add' test currently fails in the 'after
> > delete' testcase.
> 
> I guess it only fails if you use "-i" option to use "ip mptcp" instead
> of "pm_nl_ctl", right?
>

Yes, exactly.

> MPTCP CI doesn't launch the tests with the "-i" option.
> 
> Can you mention that it fails only when using "ip mptcp" which is not
> the default mode please? It might be good to include that in the title
> too not to think the test is broken and the CI didn't complain about that.
>

Sure, will do that.

> BTW, how did you launch mptcp_join.sh selftest to have this test
> launched as second position ("002")? With "-Ii"?
> 

Yes, that's exactly the case, I use "./mptcp_join.sh -I -i"

> (you can remove this "002": it is specific to the way you launched the
> test, not using the default mode)

Will do.

> 
> > This happens because endpoint delete includes an ip address while id is
> > not 0, contrary to what is indicated in the ip mptcp man page:
> > 
> > "When used with the delete id operation, an IFADDR is only included when
> > the ID is 0."
> > 
> > This fixes the issue simply not using the $addr variable in
> > pm_nl_del_endpoint().
> 
> If you do that, are you not going to break other tests? e.g.
> - "remove id 0 subflow"
> - "remove id 0 address"
> 
> (I didn't check all possibilities, maybe not or maybe there are others)
> 
> Because if you specify the ID 0, you do need to specify the address, no?
> 

That's right, of course. I'll fix that in v2 and make sure no other
tests are impacted with a "mptcp_join.sh -i" run.

> > Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
> > Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 0ae8cafde439..5424dcacfffa 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -678,7 +678,7 @@ pm_nl_del_endpoint()
> >  	local addr=$3
> >  
> >  	if [ $ip_mptcp -eq 1 ]; then
> > -		ip -n $ns mptcp endpoint delete id $id $addr
> > +		ip -n $ns mptcp endpoint delete id $id
> 
> Should you not add "${addr}" only if ${id} == 1?
> 
> >  	else
> >  		ip netns exec $ns ./pm_nl_ctl del $id $addr
> >  	fi
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 


