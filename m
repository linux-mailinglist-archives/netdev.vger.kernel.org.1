Return-Path: <netdev+bounces-282705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHjKJekS82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D649F413
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84273021732
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB94F38E106;
	Thu, 30 Apr 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io+MIQvL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMjr9VFf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2C3A382B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537750; cv=none; b=ABb35KKQo/UvSsLdkk/D3dS8YklBTyHrW2Iw2N8TpiPIJ+hFB1l0sso8W++AZk6s3ghE0ok9biN5P5n4B6gzDSRHekcoHvf8WBmAUYIEsBKFjxZAweVqYGwITmlwe981sQ5zXPUIvTjFC9rWs4GBsINxQzMbg2fAm8GAZ5dO+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537750; c=relaxed/simple;
	bh=c7rrgbDNaWx49IkoCa+VNwPwPYIyps0ET+8N+CKe18Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKXJAl6HHSIN8HiKnTOk/HLA8kXqKZuo01Ypy8iZhffsbNnkL5IyvjTTobsXJ5fQezdBuVrXNqXojd1kP1YmGmYsFY2KDOPcyLYTXBlNyjUydh3z5bt4mR3QnS3T/qyl47qSQcQjoCUORkMj9R+QpVuhz6sD/A2ZXey2H6PJ0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io+MIQvL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMjr9VFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777537748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2gMTGc30/EDWLq6m/GN9vNXkpzc+VZhhpRvIEP0ZU=;
	b=Io+MIQvLYDzEXfSaXuf3FPl4El+faTdqTkHL9oFVlJ+NaSwHziExedLgTuB5xuCO3pIoeZ
	ZSuoTdlt0I6jwrAnfPk9HJp8hoVGcVGQZjnrLyjWTP1zu9G8kGuMFA1SkUpxiWrm8xBHfv
	hDKfvbbX/G82SPi04hk50EAMMzSM+6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-S4F4gE8hOdq7XUkkjh732Q-1; Thu, 30 Apr 2026 04:29:06 -0400
X-MC-Unique: S4F4gE8hOdq7XUkkjh732Q-1
X-Mimecast-MFC-AGG-ID: S4F4gE8hOdq7XUkkjh732Q_1777537745
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so6593625e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777537745; x=1778142545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GE2gMTGc30/EDWLq6m/GN9vNXkpzc+VZhhpRvIEP0ZU=;
        b=RMjr9VFfy2TkkwCfGIv5DaRi8ZJ6d+FCyhFEGBos9ZGoYsoGt/D5I67TSTts/TyWzV
         1oM/CPWT5CXJVxgRKfVGu2mGxJH2nKlEysfFP32ooj+xynUK2qTQH3BTfhND+svmwPP3
         8/BsFNNkk1wI/QP6njbOmSh3+0XD6JwKcA25Ke3xh+8rMg2yssgzhXR2pvS8TOxcoueQ
         6kG5fb5+3EdjKFaC9UnyW2+YKseU4N1PqJYuqHJdL82x9taP7rnlqVs0CP7l5rrF/Mby
         kA6LuBQdd8vOPJVs6evQMW6T1CyEzRTgtPcSuFRpHSZmv5B9bt/SVXpRdH/2fRYgn+WX
         nNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777537745; x=1778142545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GE2gMTGc30/EDWLq6m/GN9vNXkpzc+VZhhpRvIEP0ZU=;
        b=lqJ4x7A7h+35M0X3lZmp0qQCsakNO1KDgJzZ1dBwQSHDvj26E/LN1yMi0UJqi0eXUW
         VOB8Oj3HN7P3Z+v6VMdsadhSmwnfLT9U9PovNrAMx6n0Z7SgNieRrgrGedlfHZZOAcvT
         ONFIa7WWJGh67Umkdjl0eKbrwbx0bT08aswh11aYkl4/lWXh3gUaBtRakihoGEMAxoHr
         HbWFEqZ2Lmg4cYWByD4+623uE9czaGS5JSd+aIniip6XlKkngZcSHNYDB1E4P/t+zlHF
         skP7+8hldfVQK3dvxNellE6iUZ/dGapQCd/+ykH3kxOwHhAEJKfu5GXTtcSxctyF2QPb
         RgqA==
X-Forwarded-Encrypted: i=1; AFNElJ+ve666qMSChAUnntrH2XYhYrx4r5ZHtV/yrvByIQ+YNmRF/PemtKJHGVhiEkVKPRxztHLYgrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWkW9BCAY8VrvyERd+cr5F0EjzBz9jMIWI/aOOZIVHfhZyH5+
	tkn2EzEO1V1JTn7pWoer3Zjt4VwX4VPIgdp2k+PliPd7RoNIFMNfLEOZqJMT1i9JvuHvap5pyUj
	LJ0n3OlR2rqKnz9EFfBv+cKZQXEEe65wvamyKeY3C3LmDdc51tWn3mF3SwA==
X-Gm-Gg: AeBDieu0hENeTXYZMFCSvVtTaKfdXEx9RUsS35X9D0q/+c3uCtA5sZUqPCfZj2Fcl9j
	GSf4+AMZo/d4cCq7OL7qJT0tB3iKCcJ1K56VwjoldZ1X81g+zexhrliDx1MB09S+6omw0rPG55o
	v0xGRQKYBWTb8V9iKF9Q0XeR401aFjCo5249efh542q8Q4EF/7SVvINANt0yRit5IE9RjilpMr3
	dUy962kSMD77Q2iR9b3QoQyQYShZBB+XWc41q9kmiqr21zTkWcKxtIEvBzBXj6DpFtBO/7/SZ6D
	toy1ptHxg42GiLWGxD484Dh3wsnB4XBpWROs4+Vra/dZNTs/lgm0o0kjhWTbjqDoH996BD0sL1R
	CsPhpOLq1IyKv4jiTm4Cg2lT/spOBZ4/fJ3nv7Pu5DDG27wCjmG/MiuF5FRX/7UwnmQ==
X-Received: by 2002:a05:6000:2f8a:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-449400c5308mr2851290f8f.41.1777537744659;
        Thu, 30 Apr 2026 01:29:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2f8a:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-449400c5308mr2851225f8f.41.1777537744088;
        Thu, 30 Apr 2026 01:29:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d4843bsm11132758f8f.7.2026.04.30.01.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 01:29:03 -0700 (PDT)
Message-ID: <1d10fa79-0b95-4045-a38e-ce73b5445de7@redhat.com>
Date: Thu, 30 Apr 2026 10:29:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 4/5] net: wangxun: extract the close_suspend
 sequence
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Breno Leitao <leitao@debian.org>,
 Joe Damato <joe@dama.to>, Jacob Keller <jacob.e.keller@intel.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
References: <20260428021156.13564-1-jiawenwu@trustnetic.com>
 <20260428021156.13564-5-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428021156.13564-5-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 212D649F413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	TAGGED_FROM(0.00)[bounces-282705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 4:11 AM, Jiawen Wu wrote:
> @@ -510,6 +511,16 @@ void ngbe_up(struct wx *wx)
>  	ngbe_up_complete(wx);
>  }
>  
> +void ngbe_close_suspend(struct wx *wx)
> +{
> +	wx_ptp_suspend(wx);

Sashiko says:

Does this introduce a redundant call to wx_ptp_suspend()?
Both ngbe_close() and txgbe_close() call wx_ptp_stop() immediately before
conditionally calling ngbe_close_suspend() or txgbe_close_suspend().
Looking at wx_ptp_stop(), it already executes wx_ptp_suspend() as its first
operation.
While test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state) makes the second
call safe, it seems to be redundant execution.

> +	ngbe_down(wx);
> +	wx_free_irq(wx);
> +	wx_free_isb_resources(wx);
> +	wx_free_resources(wx);
> +	phylink_disconnect_phy(wx->phylink);
> +}
> +
>  /**
>   * ngbe_close - Disables a network interface
>   * @netdev: network interface device structure
> @@ -526,11 +537,8 @@ static int ngbe_close(struct net_device *netdev)
>  	struct wx *wx = netdev_priv(netdev);
>  
>  	wx_ptp_stop(wx);
> -	ngbe_down(wx);
> -	wx_free_irq(wx);
> -	wx_free_isb_resources(wx);
> -	wx_free_resources(wx);
> -	phylink_disconnect_phy(wx->phylink);
> +	if (netif_device_present(netdev))
> +		ngbe_close_suspend(wx);

Sashiko says:

On the ngbe side, can this skip the teardown sequence entirely on the
suspend/shutdown paths?
ngbe_dev_shutdown() (shared by .suspend and .shutdown) does:
    static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
    {
            ...
            netif_device_detach(netdev);
            if (netif_running(netdev))
                    ngbe_close(netdev);
            wx_clear_interrupt_scheme(wx);
            ...
    }
netif_device_detach() clears __LINK_STATE_PRESENT, so by the time
ngbe_close() runs, netif_device_present(netdev) returns false and the new
guard
    if (netif_device_present(netdev))
            ngbe_close_suspend(wx);
skips ngbe_close_suspend() on the suspend and shutdown paths.  Before this
patch ngbe_close() unconditionally ran ngbe_down(), wx_free_irq(),
wx_free_isb_resources(), wx_free_resources() and
phylink_disconnect_phy() on those paths.
Does that mean after this patch, suspend and shutdown:
  - leave the requested MSI-X / legacy IRQ handlers registered while
    wx_clear_interrupt_scheme() subsequently frees the vector pool,
  - leak the coherent ISB DMA buffer (isb_mem / isb_dma) freed in
    wx_free_isb_resources(),
  - leak the TX/RX ring DMA allocations freed in wx_free_resources(),
  - leave phylink connected (no phylink_disconnect_phy()), so resume
    re-enters phylink_connect_phy on an already connected state, and
  - skip ngbe_down() / ngbe_reset(), so the MAC is not quiesced before
    pci_disable_device()?
The txgbe shutdown path avoids this because txgbe_dev_shutdown() calls
txgbe_close_suspend() directly rather than going through txgbe_close():
    static void txgbe_dev_shutdown(struct pci_dev *pdev)
    {
            ...
            netif_device_detach(netdev);
            rtnl_lock();
            if (netif_running(netdev))
                    txgbe_close_suspend(wx);
            rtnl_unlock();
            ...
    }
Would an equivalent change in ngbe_dev_shutdown() (call
ngbe_close_suspend() directly instead of ngbe_close()) be the intended
pairing for the new guard in ngbe_close()?

/P


