Return-Path: <netdev+bounces-299912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CP9mGKV7MWoEkgUAu9opvQ
	(envelope-from <netdev+bounces-299912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:36:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4ED69242A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=R4DLgviK;
	dkim=pass header.d=redhat.com header.s=google header.b=JOMP4+Xq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299912-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299912-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A64F23050F8C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2846AEFC;
	Tue, 16 Jun 2026 16:13:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31111466B5E
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:13:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626420; cv=none; b=izV0Kjkuj5GIKklOXizg2IojnctjbPu1vbJX88nSpRpFZnK6JAXxh4bdTQmYq6a3xVeGh52M8aDlX8NYQHUxGXED1IbMkIkJiRKI00MVcOqfUXxVY8KV0Kpef6NSrOkW2VSleeay/SsXdynJvsQqUyE/KRGzYTz1bTSLXt/7wyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626420; c=relaxed/simple;
	bh=I6hDshcql7hu2jZUKkXZROC4LwQYUnvoGKyBIzxyt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCL/rgkLz5+azLXS1OLFwTEd7sKXm1/kaxqG2TllU8SsGfHjqkgnXfFrCkfbEhKgVcHZCCEYgjkyX5mbUqdO6/nnO0VC7WSEzzIA7ZiM/zfb51AQIkfBvRrlxZ5RD1ADv23SwNQWnlNOhcnSnvdlNOXXTlZdmZCOVjQCkOeJS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4DLgviK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOMP4+Xq; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
	b=R4DLgviK8hRGCGootfTj5V3DebmEqHf8hYtRVEwpMik2QpEVrptOXsGSECpOEj3pwJ22sm
	6aOgBvek6OqhGWHSZH97Zu3OGMCYETnPBWg3gCrMQXAl7MdJ69gs6sHtTAGSSEvvPfMDsK
	Ucb71QVPqYCT+1UiVaYqxrMfb7+a3qs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-ugDX6D33MMyueaZQLlK5jw-1; Tue, 16 Jun 2026 12:13:34 -0400
X-MC-Unique: ugDX6D33MMyueaZQLlK5jw-1
X-Mimecast-MFC-AGG-ID: ugDX6D33MMyueaZQLlK5jw_1781626413
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef4931de5so7295f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781626413; x=1782231213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
        b=JOMP4+Xqppz7SBR63V9fZVBS6J3VxD32DpcR2+8areH2Z1zYuTS4w2hbgxE5V3ebxc
         AvrWAtrF0hN6Xt6uoy+AyBxriFJwSNYP8arO56Bg71tJfotuVCLLVdIHa7Hp9tKO0R2C
         ra/xYA0PFXZrN069fi0+r/mrhIf0hZpf7mx4pdrP9o3njN1jGCjDsR/AFLBwrcdTRpFG
         SomjjSIfsEAg8PMcPqEu5qzS/Az7v5vz5DZBN4nuu3mXjRtNbfuubjhhdMu0qrTTAd1S
         9aK0LuuYm5eKIZzDBNDGUlQRZoTu6okTIi9LNRPlACVdhqlDgJvHyoHVnOBtfEVRP8/q
         dklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626413; x=1782231213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
        b=f/F5UCu5mKtB4x82ywFKlkVvQfqKKxuP2X89p8D52ERC1CC5LyaWDgqM0pOtGQABRT
         0d2GsIfb6LsBu61cX85y//P1W7MSBrCuoZqBpZvGUDDfBgOmOf9yAv00/F2iFO7hiDca
         c6J00rRjmHijCenKerCVZHlfdHammXeonZr7bEJ3Ou2kwWfKLol3lwlWEe68b89saWMA
         PWTMtr8zmjCaKNd5AELjrfDd4HimuyxOowjhi06Wo9x37uIChgQAvuaKThKkzuwZsBdh
         rsyEG1I1tgvr0G9xhnJe+S8rF1HKJSyYNVmqWSoDYF5e5T+GKo/LQ/F8j2Iorjj6JjWL
         gssA==
X-Forwarded-Encrypted: i=1; AFNElJ/r+cp06ecpd8iz7+tGW0L7w3eWSRti6gDkCHtNfUILfW+tT9MKO13q89jgdFZAqzXwcWbFKw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuagBQdqujpK/iore9cRFDuBHmI1kdtr9fsVZxn+W2pDsDkRO
	tJ8Lbh4K4ft6wsjQ1XYRc6v2cHGMQvNgKw0Tj6YYZTvsm+e7UkeudattxKO4EPmGQayyu8uwK4Q
	dAkZEr8DHbkpG2vCY25JOjKktmz52jzEU+FkmWJXtLw1tjfuqi23gFENeGQ==
X-Gm-Gg: Acq92OEB4E6owhCFyi/ixYkO8JuGKO5znP9uU98sbGlYl3+c6AB+ifyDt8avJlkNlsM
	jwkmhoW5W88VlFnzaytwqbpGoCk6NhyL+sVXUtJ2sQcv1z0IpuBD6EKtbSK5hGcnWvTvMyRidPc
	DSlpt87Qr3uSP3biq5OpZMGEa1LPoh0cVWzYaNY/KSsujFAnaICZaTA149bom/jawUxeVVCgH/5
	fOKnXkV7QljKofoKa71npNQT04/xmFMLcKc/iWiUlN0FSj69Yoe68WanT1YMosznwP9Cfz27SbD
	kMYswaQQP1eDFDiKwssi3vPa08JFRiggScTUBmee9apzfcQmbNphRPu4CSrps2PeGyi7n7kZh21
	ZTAlIznA/OGb4fh1xCjIMRk58f6VZjf4lrgF7lzSO2Q0s7259qH3tRujAY/7cInrGXUAGALM=
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4760545e9.2.1781626413333;
        Tue, 16 Jun 2026 09:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4759895e9.2.1781626412794;
        Tue, 16 Jun 2026 09:13:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm41852524f8f.27.2026.06.16.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:13:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:13:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajF0To9N3yc2NlIr@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
 <ajFUk7quPhbI7Te-@sgarzare-redhat>
 <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgarzare-redhat:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B4ED69242A

On Tue, Jun 16, 2026 at 06:58:40PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 5:18 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:

[...]

>>> static u32 vhost_transport_get_local_cid(void)
>>> @@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>>> 	 * the mutex would be too expensive in this hot path, and we already have
>>> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
>>> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>>> +	 *
>>> +	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>>> +	 * The kick in vhost_vsock_start() will drain them on resume.
>>> 	 */
>>> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>>> -		rcu_read_unlock();
>>> -		kfree_skb(skb);
>>> ]		return -EHOSTUNREACH;
>>> +		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>>> +		if (!READ_ONCE(vsock->cpr_paused)) {
>>
>> Can we avoid this which is not really readable and maybe add a single
>> variable to control the fast-fail at all?
>>
>> I mean replacing both cpr_paused + backend-pointer with a single
>> `started` flag: set it to false at open, true on start via
>> smp_store_release(), back to false on normal stop, and leave it true
>> during CPR pause.
>>
>> The reader in send_pkt can do just:
>>
>>      if (!smp_load_acquire(&vsock->started))
>>          return -EHOSTUNREACH;
>>
>> WDYT?
>>
>
>I don't think it's gonna work as suggested.  As I understand, the order
>during CPR migration is:
>
>1) SET_RUNNING(0)
>       -> vhost_vsock_stop()
>           -> vhost_vsock_drop_backends()
>2) RESET_OWNER
>       -> vhost_vsock_drop_backends()
>3) SET_OWNER
>4) SET_RUNNING(1)
>       -> vhost_vsock_start
>           -> for (...) vhost_vq_set_backend()
>
>(Btw I just noticed backends are already NULL at step 2), but that's
>just our CPR case, for any potential RESET_OWNER users it might not be
>the case).
>
>So the race windows starts from 1) (not from 2)).  We have no way of
>differentiating whether device is actually being stopped for good, or
>we're in the middle of CPR.  If we set the flag to false on stop as you
>suggested, we'll still hit the -EHOSTUNREACH case eventually, and
>avoiding it is the whole purpose of this patch.
>
>The fast-fail with -EHOSTUNREACH relies on the presence of backends.
>IIUC the backend will only become set after initial SET_RUNNING(1),
>which will only happen once the guest driver writes smth to virtio
>config register, QEMU catches it and calls SET_RUNNING(1).  So we have
>ordering with the guest's actions here, which is logical.  But for our
>issue that means that the only true marker of paused/not paused is the
>presence of backends - and that's why the flag is set in
>vhost_vsock_drop_backends().

Okay, so what about avoiding to set `started` to false in 
SET_RUNNING(0)? I mean use it just to track the first SET_RUNNING(1).
(And maybe changing the name to that variable).

Apart from CPR, when can SET_RUNNING(0) occur?

At the end that was just an optimization, if we queue the packet is not 
a big issue IMO.

>
>>> +			rcu_read_unlock();
>>> +			kfree_skb(skb);
>>> +			return -EHOSTUNREACH;
>>> +		}
>>
>>
>> That said claude here is reporting a potential issue that I think we
>> should consider:
>>      After VHOST_RESET_OWNER, the guest CID stays in the hash, so
>>      vhost_transport_send_pkt() can still find the vsock, skip the
>>      fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while
>>      vhost_workers_free() is freeing workers without a synchronize_rcu()
>>      — risking a use-after-free. Also, any send_pkt_work queued between
>>      the last flush and worker teardown gets its VHOST_WORK_QUEUED 
>>      bit
>>      stuck (the vhost task exits without draining), deadlocking
>>      host→guest traffic after restart.
>>
>>      A synchronize_rcu() in vhost_workers_free() between the
>>      rcu_assign_pointer(NULL) loop and the destroy loop would close the
>>      use-after-free, and reinitializing send_pkt_work via
>>      vhost_work_init() after vhost_dev_reset_owner() returns would clear
>>      the stuck QUEUED bit.
>>
>>
>
>Yes, this looks real indeed.  Though I couldn't hit the UAF issue while
>testing host->guest transfer under KASAN.
>
>>> 	}
>>>
>>> 	if (virtio_vsock_skb_reply(skb))
>>> @@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>>> 		mutex_unlock(&vq->mutex);
>>> 	}
>>>
>>> +	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	WRITE_ONCE(vsock->cpr_paused, false);
>>> +
>>> 	/* Some packets may have been queued before the device was started,
>>> 	 * let's kick the send worker to send them.
>>> 	 */
>>> @@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>>>
>>> 	lockdep_assert_held(&vsock->dev.mutex);
>>>
>>> +	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>>> +		WRITE_ONCE(vsock->cpr_paused, true);
>>> +		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	}
>>
>> Why here and not in vhost_vsock_reset_owner()?
>>
>> Also having this here will set it to true also with
>> VHOST_VSOCK_SET_RUNNING(0), is that right?
>>
>
>That was added here precisely to cover the vhost_vsock_stop() case (see
>above).

I see now, a comment or something in the commit would have helped.

Thanks,
Stefano


