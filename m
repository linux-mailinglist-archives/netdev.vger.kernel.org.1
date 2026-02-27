Return-Path: <netdev+bounces-261656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCevBQT0oGk8oQQAu9opvQ
	(envelope-from <netdev+bounces-261656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87721B181B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740533020D46
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74C22256F;
	Fri, 27 Feb 2026 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p/8BraO0"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E9187FE4
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155902; cv=none; b=DobcBFBIODrYYv04iCGSIgPQOwD2JWtW73wmraC0H8yC3D5gNCtzzBbb5TLMugCfjoQziGg3YYxXjwRnyu2YZX3j5ycVM6iLUf9tgKwkJ4+Ist51pZT490jJ4EAFQuhAvr0Q/s3EO+/jAoPsGmOgvxcc5n1rEqQaTO79J408hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155902; c=relaxed/simple;
	bh=hqheYRc43HDtNaR7aUSfolBFpbZ/VGSmlZKqFAhKolY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gv+qA/ecx3k2fYZD28pMzzS+aGWgglK2yIHhBEyE7wyTwL39V8pq4psRdLE2P9WIFzjBcTS4l+t7OzFcc5qWpypmL4WvdjXFJSGY09mmWVXZcS0U7cOhSjLu7qfpTLK4NmeWBmwuoE08s+tCnJmjXvG0lGIlDAdm3JfXG9zeiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p/8BraO0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rW3xZWk5lWYICDtFIDdH8Xx9wVRUzr3JzXeSaQ71JFc=; b=p/8BraO0LOVTelsR3dKmotzkkr
	w6/8DqlOUk71nkyW2Ok1xceVEQvcrdSJLEaZR2Xp/9bVSo+RP9dprtepI2AF97oT0nrGHHMfv1DsS
	dHiqu+8Ck8Bp1aVG2AQCrCYvcsCBCGUpeF75XVIVnVqWwfj0Coi9CxsVoTMMMOrjK2vv790lg0eLP
	ypjvUhFZGLn8Yjb+tDDFP2qx1AmvTE2Uy2ILqTIqJBG2CYI1qHUr+vGJgV2VvR+3lDKhhhXf7bI85
	IrOZ7Nlckpp9kwlMEwin+1h0V+xoTx0MB6DFN+JcoBQ7CKFvJoZSWz5oaJCdilYiKPTaX7Q0EjQSL
	xj0s0sEQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvmhc-00000007UPE-1nw7;
	Fri, 27 Feb 2026 01:31:36 +0000
Message-ID: <1fe73b4e-8a18-4369-96a2-8e286ba60aab@infradead.org>
Date: Thu, 26 Feb 2026 17:31:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org
References: <20260226221054.1041044-1-rdunlap@infradead.org>
 <20260226165629.377fd10d@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260226165629.377fd10d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: D87721B181B
X-Rspamd-Action: no action



On 2/26/26 4:56 PM, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 14:10:54 -0800 Randy Dunlap wrote:
>> +	/* private: */
>>  	OVS_DP_ATTR_UNSPEC,
>> +	/* public: */
> 
> Hm, can't quickly grep the relevant guidance but I always thought that

I don't think there is any relevant guidance unless you consider an example
in Documentation/doc-guide/kernel-doc.rst to be guidance, where the example
does agree with your comment.

But kernel-doc doesn't have any _requirement_ that these comments begin
in column 1.

> the comment is supposed to pretend to be a label. IOW not be indented:
> 
>  enum ovs_datapath_attr {
>  /* private: */
>  	OVS_DP_ATTR_UNSPEC,
>  /* public: */
>  	OVS_DP_ATTR_NAME,		/* name of dp_ifindex netdev */
> 
> I find that easier to read, but no strong preference.

-- 
~Randy


