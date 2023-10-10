Return-Path: <netdev+bounces-39394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378637BEFD4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385DA1C209A6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D037D;
	Tue, 10 Oct 2023 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skym.fi header.i=@skym.fi header.b="2uklJJdD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSCO8y8y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE6377
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:40:13 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DFCA3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:40:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 72D045C023A;
	Mon,  9 Oct 2023 20:40:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1696898411; x=1696984811; bh=+glOfiTjqfdNldkd4BXd9p9Xrv4mX9YhR9w
	WiKhcj40=; b=2uklJJdDYBEuHQVSNfcdIIkodEDzfPNzishpK8ZkWEv58ixkX1M
	LJv1mxrx5wfoenAW+5Oyp1pJu3Vt7VQ1q3ddYhfW3ZUkO47fOCMfCU3K2A8nIwIt
	hydZmh0DpJHuj2teRd3jX66aTlZZCjP7Tj2EsQpu4pbedLX5Ug2A9p+OLJkFrxLh
	U29unOLhFbaMNJmWKDbFx2z2N/UgmEEa5KJseJT4PIkopIuLIfR7gPGaJioeKF4H
	t8CRrOg5EjANibHPQs9xrV8OmYEg+Cq+8I5CV3ZiLx0/vfX0KQu9dssVy8pc55QJ
	2OWm97KcaOkobdkZRwy5RuQAB2LhodqmbVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1696898411; x=1696984811; bh=+glOfiTjqfdNldkd4BXd9p9Xrv4mX9YhR9w
	WiKhcj40=; b=aSCO8y8y9nZOgKPNpJmOWtFUrJRKZd0lD7LytkjY7z0XJiU2b3t
	+MB/6AWc41OClpMtCiivRSd7nVyciSPE2rRTfc3oAXEeWWfsPoXo5jgeTWhV80L+
	GB1zT+Hjx4Y8Ndvx6W/6qG4CQQn99Osh80c7b1tZNNWFIpm4Qu7xE61Lrw0Y9BJC
	BiCFxOVUJrYpH3k/mcLF720Q6a9YQRmXhBrNwxk8mhLGYCqhj5aE/RJ772Bc5ZlR
	Pv0MibfgXMksE71hENVS46H9W/Ipooly46id3OmsPyXZkY0mMy9Z0YkaxqkLrmeJ
	KYW4dgJwQElm6DfA1E0Q7Y0gzk2d2nFJ9Wg==
X-ME-Sender: <xms:a50kZWJA28v956qE8_ZAxw3o0QmJ1Uevq8LRIajoYRpPlRRprw7ftQ>
    <xme:a50kZeKRgGaoGf77uA25ISdWe8clLkSQgf9cgO7axTBhYV1rs0JprGBGfZ110Cl_c
    bkL6AxmiM9nIbvGMjc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpefukhih
    lhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhsthhssehskhihmhdrfhhiqeenuc
    ggtffrrghtthgvrhhnpeeuudevveefueduueelveegheelffegleetfeeikeefudelgfel
    gfetudefuddvvdenucffohhmrghinhepvhihohhsrdhiohdpkhgrphhsihdrfhhinecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhmodhlihhs
    thhssehskhihmhdrfhhi
X-ME-Proxy: <xmx:a50kZWuBh5cRoUspBouowzmKzOM_Z6F8ncGXj_KLWvy30BP9Y_xp1g>
    <xmx:a50kZbaof6CweFrYVI8uO8sol_bcs1ZNUOF3HwxtSNE5FDZ5JkJeHA>
    <xmx:a50kZdYd-p9wrd47U_wgv7yRlxg24FAahFREWbuDYct_t3fap4U2FQ>
    <xmx:a50kZeBAnQMZWl3f9GOUREpLjHfNconJta4rv0qM21qd1_EGXndm7Q>
Feedback-ID: id05146f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0585C15A0091; Mon,  9 Oct 2023 20:40:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
In-Reply-To: <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
 <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
Date: Tue, 10 Oct 2023 03:39:46 +0300
From: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <sm+lists@skym.fi>
To: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and FreeBSD's
 with Intel X533
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023, at 02:50, Skyler M=C3=A4ntysaari wrote:
> On Mon, Oct 9, 2023, at 18:33, Jesse Brandeburg wrote:
>> On 10/4/2023 10:08 AM, Skyler M=C3=A4ntysaari wrote:
>>>>> Hi there,
>>>>>
>>>>> It seems that for reasons unknown to me, my Intel X533 based 10G S=
FP+
>>>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 =
but
>>>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>>>
>>>>> How would I go about debugging this properly? Both sides see light,
>>>>> but no link unless I'm using FreeBSD.
>>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/1225=
3/11?u=3Dsamip537
>>
>> Hi Skyler,
>>
>> Response from Intel team:
>>
>> In the ethtool -m output pasted I see TX and RX optical power is fine.
>> Could you request fault status on both sides? Just want to check if l=
ink
>> is down because we are at local-fault or link partner is at local-fau=
lt.
>>
>> rmmod ixgbe
>> modprobe ixgbe
>> ethtool -S eth0 | grep fault
>>
>> Since it is 10G, if our side TX is ON (power level says it is) then we
>> should expect link partner RX to be locked so cannot be at Local Faul=
t.
>>
>> Skyler, please gather that ethtool -S data for us.
>>
>> Jesse
>>
>>
>>
>>=20
>
> Hi Jesse,
>
> As the other side of the link is an Juniper, I'm not quite sure how I=20
> would gather the same data from it as it doesn't have ethtool?
>
> I have also somewhat given up hope on it working on VyOS and instead I=20
> am using OPNsense for the moment but I still have VyOS installed as=20
> well.
>
> Skyler

Hi Jesse,

I did verify that the grep doesn't yield any results on the VyOS box and=
 all of the data returned has an value of 0. Paste of which is here: htt=
ps://p.kapsi.fi/?4a82cedb4f4801ec#DcEgFMFK7cH13EqypsY4ZaHS5taeA1zXevmmTS=
VW3P9x

I really think something weird is going on with the driver in Linux as o=
therwise the same exact config on Juniper wouldn't work there either. Th=
e VyOS box also says that it's unable to modify autoneg settings, or spe=
ed/duplex of the interface.

Skyler

